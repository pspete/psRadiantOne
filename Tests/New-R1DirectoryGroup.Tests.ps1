#InModuleScope is resolved during Pester's discovery phase, so the module must be imported here
#rather than from BeforeAll, which does not run until the later run phase.

#Get Current Directory
$Here = Split-Path -Parent $PSCommandPath

#Module Name
$ModuleName = 'psRadiantOne'

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if ( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

Describe $($PSCommandPath -Replace '.Tests.ps1') {

	InModuleScope 'psRadiantOne' {

		BeforeEach {

			$psRadiantOneSession = [ordered]@{
				BaseURI            = 'https://radiantone.company.com'
				User               = 'uid=testuser,ou=globalusers,cn=config'
				Token              = 'SomeToken'
				TokenExpiry        = $null
				Privileges         = $null
				Organization       = $null
				Version            = $null
				WebSession         = $null
				StartTime          = $null
				ElapsedTime        = $null
				LastCommand        = $null
				LastCommandTime    = $null
				LastCommandResults = $null
				LastError          = $null
				LastErrorTime      = $null
			}
			New-Variable -Name psRadiantOneSession -Value $psRadiantOneSession -Scope Script -Force

			Mock Invoke-R1RestMethod -MockWith { }

			New-R1DirectoryGroup -cn 'SomeGroup' -parentDn 'ou=zOU,o=companydirectory' -description 'SomeGroup' -sAMAccountName 'SomeGroup' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the dn built from the cn and parent' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).dn -eq 'cn=SomeGroup,ou=zOU,o=companydirectory'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the attributes the control panel sends' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Names = @($Decoded.attributes | ForEach-Object { $PSItem.name }) | Sort-Object
					($Names -join ',') -eq 'cn,description,objectClass,sAMAccountName'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a static group by default' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					($oc.values -join ',') -eq 'top,group'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends <Expected> for type <Type>' -TestCases @(
				@{ Type = 'groupofnames'; Expected = 'top,groupOfNames' }
				@{ Type = 'groupOfUniqueNames'; Expected = 'top,groupOfUniqueNames' }
			) {

				param($Type, $Expected)

				New-R1DirectoryGroup -cn 'Typed' -parentDn 'o=x' -sAMAccountName 'x' -type $Type -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					($Decoded.dn -eq 'cn=Typed,o=x') -and (($oc.values -join ',') -ceq $Expected)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends groupOfURLs for a dynamic <Type>' -TestCases @(
				@{ Type = 'group'; Expected = 'top,group,groupOfURLs' }
				@{ Type = 'groupOfNames'; Expected = 'top,groupOfNames,groupOfURLs' }
			) {

				param($Type, $Expected)

				New-R1DirectoryGroup -cn 'Dynamic' -parentDn 'o=x' -sAMAccountName 'x' -type $Type -dynamic $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Names = @($Decoded.attributes | ForEach-Object { $PSItem.name }) | Sort-Object
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					($Decoded.dn -eq 'cn=Dynamic,o=x') -and (($oc.values -join ',') -ceq $Expected) -and (($Names -join ',') -eq 'cn,objectClass,sAMAccountName')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends nothing with WhatIf' {

				New-R1DirectoryGroup -cn 'A' -parentDn 'o=x' -sAMAccountName 'x' -WhatIf

				#The one call is the BeforeEach call
				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

		}

	}

}
