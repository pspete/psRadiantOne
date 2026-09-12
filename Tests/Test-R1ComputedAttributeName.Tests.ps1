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

			Mock Invoke-R1RestMethod -MockWith {
				[pscustomobject]@{ 'isValid' = $true }
			}

			$response = Test-R1ComputedAttributeName -computedAttributeName 'myAttr'

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -match '^https://radiantone\.company\.com/directory-namespace-service/naming_context_utils/validate_computed_attr_name\?'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the value as a query parameter' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -match 'computedAttributeName=' } -Times 1 -Exactly -Scope It

			}

			It 'escapes the value in the query string' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -notmatch '\s' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'returns a boolean' {

				$response | Should -BeOfType [boolean]

			}

			It 'returns the validity reported by the api' {

				$response | Should -BeTrue

			}

			It 'returns false when the api reports the value invalid' {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{ 'isValid' = $false; 'errorMsg' = 'Cannot contain spaces' }
				}

				Test-R1ComputedAttributeName -computedAttributeName 'myAttr' | Should -BeFalse

			}

		}

	}

}
