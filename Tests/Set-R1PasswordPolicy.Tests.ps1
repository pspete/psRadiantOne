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

			#The command asks the listing whether the policy exists, reads it when it does, and
			#starts from the empty policy the API supplies when it does not
			Mock Get-R1PasswordPolicy -MockWith {
				if ($NewPolicy) {
					[pscustomobject]@{ name = ''; targetType = $null; targetDn = $null; precedence = 1000; passwordMinLength = 0 }
				} elseif ($policyName) {
					[pscustomobject]@{
						name                         = 'Default'
						targetType                   = 'SUBTREE'
						targetDn                     = 'dc=example,dc=com'
						precedence                   = 500
						passwordMustChangeAfterReset = $true
						userMayChangePassword        = $true
						passwordMinLength            = 10
						passwordExpires              = $true
						passwordLockout              = $true
					}
				} else {
					@('Default')
				}
			}

			Set-R1PasswordPolicy -policyName 'Default' -passwordMinLength 14 -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/settings-service/password_policies/policy')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'retrieves the policy before updating it' {

				Should -Invoke -CommandName Get-R1PasswordPolicy -ParameterFilter { $policyName -eq 'Default' } -Times 1 -Exactly -Scope It

			}

			It 'starts from the empty policy when the policy does not exist' {

				Set-R1PasswordPolicy -policyName 'psr1-new' -passwordMinLength 12 -Confirm:$false

				Should -Invoke -CommandName Get-R1PasswordPolicy -ParameterFilter { $NewPolicy } -Times 1 -Exactly -Scope It

			}

			It 'does not read a policy which does not exist' {

				Set-R1PasswordPolicy -policyName 'psr1-new' -passwordMinLength 12 -Confirm:$false

				Should -Invoke -CommandName Get-R1PasswordPolicy -ParameterFilter { $policyName -eq 'psr1-new' } -Times 0 -Exactly -Scope It

			}

			It 'sends the name of the policy it is creating' {

				Set-R1PasswordPolicy -policyName 'psr1-new' -passwordMinLength 12 -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Sent = $Body | ConvertFrom-Json
					($Sent.name -eq 'psr1-new') -and ($Sent.passwordMinLength -eq 12)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).passwordMinLength -eq 14

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves settings which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$d = $Body | ConvertFrom-Json
					($d.precedence -eq 500) -and ($d.targetType -eq 'SUBTREE') -and ($d.userMayChangePassword -eq $true)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the policy name as the name property' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).name -eq 'Default'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
