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
				[pscustomobject]@{
					'name'                         = 'Default'
					'targetType'                   = 'SUBTREE'
					'targetDn'                     = 'dc=example,dc=com'
					'precedence'                   = 500
					'passwordMustChangeAfterReset' = $true
					'userMayChangePassword'        = $true
					'passwordMinLength'            = 10
					'passwordExpires'              = $true
					'passwordLockout'              = $true
				}
			}

			$response = Get-R1PasswordPolicy

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/password_policies')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'sends the required policyName query parameter when a policy is named' {

				Get-R1PasswordPolicy -policyName 'Default Policy'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/settings-service/password_policies/policy?policyName=Default%20Policy'

				} -Times 1 -Exactly -Scope It

			}

			It 'requests an empty policy when NewPolicy is specified' {

				Get-R1PasswordPolicy -NewPolicy

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/settings-service/password_policies/policy?newPolicy=true'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'has expected typename when a policy is named' {

				$result = Get-R1PasswordPolicy -policyName 'Default'
				$result.psobject.TypeNames[0] | Should -Be 'psRadiantOne.PasswordPolicy'

			}

		}

	}

}
