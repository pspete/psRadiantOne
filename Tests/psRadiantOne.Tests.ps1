#Requires -Modules Pester, PSScriptAnalyzer
<#
.SYNOPSIS
    Tests module for consistency, expected structures, settings, components & files.
.EXAMPLE
    Invoke-Pester
.NOTES
    A generic set of tests to apply to a module
#>

Describe 'Module' -Tag 'Consistency' {

	#Get Current Directory
	$Here = Split-Path -Parent $PSCommandPath

	#Assume ModuleName from Repository Root folder.
	#The .Replace('-', '.') corrects for AppVeyor checking a dotted module name's repo out
	#with the dot replaced by a hyphen (e.g. IdentityCommand.SCA -> identitycommand-sca).
	#This is a no-op for modules without a dot in the name - leave it in regardless.
	$ModuleName = (Split-Path (Split-Path $Here -Parent) -Leaf).Replace('-', '.')

	#Resolve Path to Module Directory
	$ModulePath = Resolve-Path "$Here\..\$ModuleName"

	#Define Path to Module Manifest
	$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

	Get-Module -Name $ModuleName -All | Remove-Module -Force -ErrorAction Ignore

	$Module = Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop -PassThru

	#Get Public Function Names
	$PublicFunctions = Get-ChildItem "$ModulePath\Public" -Include *.ps1 -Recurse | Select-Object -ExpandProperty BaseName

	#Get Exported Function Names
	$ExportedFunctions = $Module.ExportedFunctions.Values.name

	$ExportedAliases = $Module.ExportedAliases.Values.name

	$Scripts = Get-ChildItem $ModulePath -Include *.ps1 -Recurse

	Context $ManifestPath -Tag Manifest {

		It 'has a valid manifest' -TestCases @{ManifestPath = $ManifestPath } {
			param($ManifestPath)
			{ $null = Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop -WarningAction SilentlyContinue } |
				Should -Not -Throw

		}

		It 'specifies valid root module' -TestCases @{RootModule = $Module.RootModule ; ModuleName = $ModuleName } {
			param($RootModule, $ModuleName)
			$RootModule | Should -Be "$ModuleName.psm1"

		}

		It 'has a valid description' -TestCases @{Description = $Module.Description } {
			param($Description)
			$Description | Should -Not -BeNullOrEmpty

		}

		It 'has a valid guid' -TestCases @{Guid = $Module.Guid } {
			param($Guid)
			$Guid | Should -Be 'c7008020-b69c-48ae-9959-974642f61fe4'

		}

		It 'has a valid copyright' -TestCases @{Copyright = $Module.Copyright } {
			param($Copyright)
			$Copyright | Should -Not -BeNullOrEmpty

		}

		Context 'Files To Process' -Tag 'FilesToProcess' {

			foreach ($file in ($Module.ExportedFormatFiles)) {
				Context $file -Tag 'FormatData' {
					It 'exists' -TestCases @{
						'File' = $file
					} {
						param($File)
						$File | Should -Exist
					}

					It 'is valid' -TestCases @{
						'File' = $file
					} {
						param($File)
						{ Update-FormatData -AppendPath $File -ErrorAction Stop -WarningAction SilentlyContinue } | Should -Not -Throw
					}

				}

				foreach ($file in ($Module.ExportedTypeFiles)) {
					Context $file -Tag 'TypeData' {
						It 'exists' -TestCases @{
							'File' = $file
						} {
							param($File)
							$File | Should -Exist
						}

						It 'is valid' -TestCases @{
							'File' = $file
						} {
							param($File)
							{ Update-TypeData -AppendPath $File -ErrorAction Stop -WarningAction SilentlyContinue } | Should -Not -Throw
						}

					}
				}
			}
		}

		Context 'Exported Function Analysis' -Tag 'Functions' {

			It 'exports the expected number of functions' {

				($PublicFunctions | Measure-Object | Select-Object -ExpandProperty Count) |

					Should -Be ($ExportedFunctions | Measure-Object | Select-Object -ExpandProperty Count)

			}

			foreach ($ExportedFunction in $ExportedFunctions) {

				Context "$ExportedFunction" -Tag "$ExportedFunction" {
					It 'is public' -TestCases @{
						'ExportedFunction' = $ExportedFunction
						'PublicFunctions'  = $PublicFunctions
					} {
						param($ExportedFunction, $PublicFunctions)
						$PublicFunctions | Should -Contain $ExportedFunction
					}

					It 'has a related pester tests file' -TestCases @{
						'ExportedFunction' = $ExportedFunction
						'Here'             = $here
					} {
						param($ExportedFunction, $here)
						Test-Path (Join-Path $here "$ExportedFunction.Tests.ps1") | Should -Be $true
					}

					Context Help -Tag 'Help' {

						$help = Get-Help $ExportedFunction -Full

						It 'has synopsis' -TestCases @{ 'Help' = $help } {
							param($help)
							$help.synopsis | Should -Not -BeNullOrEmpty

						}

						It 'has description' -TestCases @{ 'Help' = $help } {
							param($help)
							$help.description | Should -Not -BeNullOrEmpty

						}

						It 'has example code' -TestCases @{ 'Help' = $help } {
							param($help)
							$help.examples.example.code | Should -Not -BeNullOrEmpty

						}

						[array]$HelpParameters = $help.parameters.parameter | Where-Object name -NotIn @('WhatIf', 'Confirm')

						foreach ($HelpParameter in $HelpParameters) {

							It 'has description of parameter <n>' -Tag "$($HelpParameter.name)" -TestCases @{
								'description' = $HelpParameter.description
								'name'        = $HelpParameter.name
							} {
								param($description, $name)
								$description | Should -Not -BeNullOrEmpty
							}

						}

					}
				}

			}

		}

		Context 'Exported Alias Analysis' -Tag Alias {

			foreach ($Alias in $ExportedAliases) {

				It '<Alias> resolves to public function' -Tag $Alias -TestCases @{
					'Alias'           = $Alias
					'PublicFunctions' = $PublicFunctions
				} {
					param($Alias, $PublicFunctions)
					$PublicFunctions | Should -Contain $((Get-Alias $Alias).ResolvedCommand.Name)
				}

			}

		}

	}

	Context 'PSScriptAnalyzer Analysis' -Tag 'PSScriptAnalyzer' {

		#One analyzer pass per file (all Warning/Error rules at once), one It block per file - this
		#keeps It count to one-per-file (avoiding an AppVeyor timeout an earlier one-It-per-rule-per-file
		#approach hit once a module grew past ~200 files) while still naming the exact rule/line on failure.
		Foreach ($Script in $scripts) {

			Context $Script.Name -Tag "$($Script.BaseName)", "$($Script.Name)" {

				It 'passes all Warning and Error rules' -TestCases @{
					'FilePath' = $script.FullName
				} {
					param($FilePath)

					$findings = Invoke-ScriptAnalyzer -Path $FilePath -Severity Warning, Error

					($findings | ForEach-Object { "[$($_.RuleName)] line $($_.Line): $($_.Message)" }) -join [System.Environment]::NewLine |
						Should -BeNullOrEmpty

				}

			}

		}

	}

	Context 'Read Modify Write' -Tag 'ReadModifyWrite' {

		#The RadiantOne update endpoints replace the resource rather than merging into it: a property
		#absent from the request is cleared, and a permission absent from a role is reset to NONE.
		#A command issuing a PUT must therefore retrieve the resource first and send it back with the
		#caller's values applied over it, which is what Merge-R1Parameter is for. Sending only the
		#bound parameters silently destroys everything the caller did not restate.

		#Commands whose PUT is not a partial update of a resource, with the reason each is exempt.
		$ReadModifyWriteExempt = @{
			'Update-R1AuthToken' = 'Refreshes the authentication token. An action with no request body.'
			'Set-R1FIDUserRole'  = 'The request body is the complete list of roles by definition, so there is nothing to preserve.'
			'Update-R1AttributeEncryptionKey' = 'Rotates the encryption key. An action whose body is the new key, not a partial update of a resource.'
			'Set-R1LdapClientAccessMapping'   = 'The request body is the complete mapping collection by definition, so there is nothing to preserve.'
			'Set-R1License'                   = 'Applies a license. The body is the license itself, which is the whole resource, so there is nothing to preserve.'
			'Set-R1CustomLimit'               = 'The request body is the complete collection of custom limits by definition, so there is nothing to preserve.'
			'Set-R1GlobalSpecialAttribute'    = 'The request body has a single property, which is the value being set, so there is nothing to preserve.'
			'Enable-R1NamingContext'          = 'Toggles the active state. The request body has a single property, which is the state being set.'
			'Disable-R1NamingContext'         = 'Toggles the active state. The request body has a single property, which is the state being set.'
			'New-R1GeneratedSchema'           = 'Generates schemas. The body is the list of schemas to generate, not a partial update of a resource.'
			'Publish-R1Schema'                = 'The request body is the complete list of published schemas by definition, so there is nothing to preserve.'
			'Set-R1SchemaTableField'          = 'The request body is the complete collection of fields by definition, so there is nothing to preserve.'
		}

		$PublicScripts = Get-ChildItem (Join-Path $ModulePath 'Public') -Include *.ps1 -Recurse

		Foreach ($Script in $PublicScripts) {

			$Content = Get-Content -Path $Script.FullName -Raw

			if ($Content -match 'Method\s+PUT') {

				if ($ReadModifyWriteExempt.ContainsKey($Script.BaseName)) {

					It "$($Script.Name) is exempt: $($ReadModifyWriteExempt[$Script.BaseName])" -Tag "$($Script.BaseName)" {
						$true | Should -BeTrue
					}

				} else {

					It "$($Script.Name) retrieves the resource before updating it" -Tag "$($Script.BaseName)" -TestCases @{
						'Content' = $Content
						'Name'    = $Script.BaseName
					} {
						param($Content, $Name)

						#Merge-R1Parameter is the usual way to apply the caller's values over the
						#retrieved resource. A command whose resource is a collection reads it and
						#rebuilds the collection instead, so calling a Get-R1 command counts too.
						#Add the command to $ReadModifyWriteExempt above, with a reason, if its PUT
						#genuinely does not need the resource retrieving first.
						$Content | Should -Match '(Merge-R1Parameter|Get-R1[A-Za-z]+)'
					}

				}

			}

		}

	}

	Context 'Secure Value Handling' -Tag 'SecureValueHandling' {

		#Any function that decodes a SecureString (or otherwise obtains a plaintext secret) and sends a
		#JSON request body via Invoke-R1RestMethod must convert that body to UTF8 bytes (not a
		#String) before the call, so Windows PowerShell ParameterBinding/Module Logging cannot capture the
		#plaintext value. See https://github.com/pspete/psPAS/issues/602

		#Fill in with the actual secret-shaped field names this module's API uses - verify against real
		#payloads, don't copy another module's list unchecked even if the platform seems related.
		$SecretFieldNames = 'password', 'newPassword', 'oldPassword', 'currentPassword', 'bindReqPassword', 'clientSecret', 'secretKey', 'accessKeySecret'
		$SecretFieldPattern = "(?i)'($($SecretFieldNames -join '|'))'"
		$SecretDecodePattern = 'ConvertTo-InsecureString'

		Foreach ($Script in $Scripts) {

			$Content = Get-Content -Path $Script.FullName -Raw

			$HandlesSecret = ($Content -match $SecretFieldPattern) -or ($Content -match $SecretDecodePattern)
			$BuildsJsonBody = ($Content -match 'ConvertTo-Json') -or ($Content -match 'ConvertTo-R1JsonBody')
			$SendsRequest = $Content -match 'Invoke-R1RestMethod'

			if ($HandlesSecret -and $BuildsJsonBody -and $SendsRequest) {

				It "$($Script.Name) converts its request body to UTF8 bytes before calling Invoke-R1RestMethod" -Tag "$($Script.BaseName)" -TestCases @{
					'Content' = $Content
				} {
					param($Content)

					#Accepts either inline UTF8 encoding, or a dedicated module-specific secret-body helper
					#(the more mature version of this pattern once one exists for this module).
					$Content | Should -Match '(\[System\.Text\.Encoding\]::UTF8\.GetBytes\(|ConvertTo-R1SecretBody)'

				}

			}

		}

		#The pattern-based scan above can't see a secret that only exists in the *caller's* data (e.g. a
		#hashtable value passed in via a parameter) rather than as literal source text in the file itself -
		#list any scripts known to handle a secret this way as explicit named exceptions here, e.g.:
		#'Set-R1Example.ps1' | ForEach-Object { ... }

	}

}
