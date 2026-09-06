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
				WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
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
				[pscustomobject]@{ 'targetDn' = 'uid=testUser,ou=globalusers,cn=config' }
			}

			$response = Test-R1AdapToken
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/adap-token/validate'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'sends specified token as bearer authorization header' {

				Test-R1AdapToken -Token 'SomeOtherToken'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($null -ne $Headers) -and ($Headers['Authorization'] -eq 'Bearer SomeOtherToken')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'returns true for a valid token' {

				$response | Should -BeTrue

			}

			It 'returns target dn when PassThru specified' {

				$result = Test-R1AdapToken -PassThru
				$result.targetDn | Should -Be 'uid=testUser,ou=globalusers,cn=config'

			}

			It 'returns false when validation fails' {

				Mock Invoke-R1RestMethod -MockWith { throw 'Unauthorized' }
				Test-R1AdapToken | Should -BeFalse

			}

		}

	}

}
