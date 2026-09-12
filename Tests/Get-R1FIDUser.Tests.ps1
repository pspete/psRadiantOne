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
				[pscustomobject]@{
					'users' = @([pscustomobject]@{ 'username' = 'john_smith' })
					'next'  = $null
				}
			}

			$response = Get-R1FIDUser
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/users'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint when username specified' {

				Get-R1FIDUser -username john_smith

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/users/john_smith'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends searchFilter as a query parameter' {

				Get-R1FIDUser -searchFilter smith

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -match 'searchFilter=smith'

				} -Times 1 -Exactly -Scope It

			}

			It 'returns the users from every page reported by the api' {

				$Script:CallCount = 0

				Mock Invoke-R1RestMethod -MockWith {
					$Script:CallCount++
					if ($Script:CallCount -eq 1) {
						[pscustomobject]@{
							'users' = @([pscustomobject]@{ 'username' = 'user1' })
							'next'  = 'https://radiantone.company.com/authentication-service/users?cursor=A5B6C7&pageSize=5'
						}
					} else {
						[pscustomobject]@{
							'users' = @([pscustomobject]@{ 'username' = 'user2' })
							'next'  = $null
						}
					}
				}

				$result = Get-R1FIDUser

				$result.username | Should -Contain 'user1'
				$result.username | Should -Contain 'user2'

			}

			It 'sends the cursor reported by the api on the following request' {

				$Script:CallCount = 0

				Mock Invoke-R1RestMethod -MockWith {
					$Script:CallCount++
					if ($Script:CallCount -eq 1) {
						[pscustomobject]@{
							'users' = @([pscustomobject]@{ 'username' = 'user1' })
							'next'  = 'https://radiantone.company.com/authentication-service/users?cursor=A5B6C7&pageSize=5'
						}
					} else {
						[pscustomobject]@{ 'users' = @(); 'next' = $null }
					}
				}

				$null = Get-R1FIDUser

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -match 'cursor=A5B6C7'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'returns the users from the response envelope' {

				$response.username | Should -Be 'john_smith'

			}

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.FIDUser'

			}

		}

	}

}
