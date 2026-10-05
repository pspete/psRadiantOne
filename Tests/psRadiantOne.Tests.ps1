#Requires -Modules Pester
<#
.SYNOPSIS
    Tests psRadiantOne-specific conventions across the module source.
.EXAMPLE
    Invoke-Pester
.NOTES
    The generic module tests come from pspete.Build (build/tests/Module.Tests.ps1).
    The built module is a single psm1 with no Public folder, so these tests find nothing to check against it.
#>

Describe 'Module' -Tag 'Consistency' {

	$ModulePath = Join-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) 'psRadiantOne'

	$Scripts = Get-ChildItem $ModulePath -Include *.ps1 -Recurse

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
			'Add-R1DataSourceSchemaLink'      = 'Links a schema. The identifiers travel in the path and query, or the body is the complete list of schemas to link.'
			'Remove-R1DataSourceSchemaLink'   = 'Unlinks a schema. The identifiers travel in the path and query, and there is no request body.'
			'Set-R1DataSourcePluginLibrary'   = 'The request body is the complete collection of library references by definition, so there is nothing to preserve.'
			'Set-R1DataSourceTypeImportMeta'  = 'The request body is the complete template definition, supplied by the caller after retrieving it.'
			'Set-R1LibraryDependency'         = 'The request body is the complete collection of dependencies by definition, so there is nothing to preserve.'
			'Set-R1JdbcDriverLibrary'         = 'The request body is the complete collection of library references by definition, so there is nothing to preserve.'
			'Set-R1Library'                   = 'Replaces the library file itself. The body is the uploaded jar, not a partial update of a resource.'
			'Set-R1DirectoryEntryMember'      = 'The request body is the complete membership list by definition, so there is nothing to preserve.'
			'Set-R1FileContent'               = 'Replaces the contents of a file. The body is the new contents, which the caller supplies whole.'
			'Reset-R1DashboardLink'           = 'Restores the default links. An action with no request body.'
			'Set-R1NamingContextInterceptionScript' = 'Points the node at an existing script. The request body has a single property, which is the script being set.'
		}

		$PublicScripts = Get-ChildItem (Join-Path $ModulePath 'Public') -Include *.ps1 -Recurse -ErrorAction Ignore

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
