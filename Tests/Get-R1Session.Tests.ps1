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
				Privileges         = @('ROLE_CONFIG_READ')
				Organization       = 'Test Org'
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

			$response = Get-R1Session

		}

		Context 'Shape' {

			It 'returns properties which Select-Object can read' {

				#On the ordered dictionary the session is held as, Select-Object found only Keys,
				#Values and Count, and returned null for everything else.
				Get-R1Session | Select-Object -ExpandProperty User | Should -Be 'uid=testuser,ou=globalusers,cn=config'

			}

			It 'keeps the token available to a caller who asks for it' {

				(Get-R1Session).Token | Should -Be 'SomeToken'

			}

			#The session is printed while working, and pasted into issues and transcripts.
			It 'does not print the token by default' {

				(Get-R1Session | Out-String) | Should -Not -Match 'SomeToken'

			}

			It 'prints the session properties a caller is looking for' {

				$Display = Get-R1Session | Out-String
				$Display | Should -Match 'BaseURI'
				$Display | Should -Match 'User'
				$Display | Should -Match 'TokenExpiry'

			}

		}

		Context 'Elapsed Time' {

			It 'reports how long the session has been open' {

				$psRadiantOneSession['StartTime'] = (Get-Date).AddMinutes(-5)
				New-Variable -Name psRadiantOneSession -Value $psRadiantOneSession -Scope Script -Force

				(Get-R1Session).ElapsedTime | Should -Match '^00:0[45]:'

			}

			It 'reports no elapsed time when no session has been started' {

				(Get-R1Session).ElapsedTime | Should -BeNullOrEmpty

			}

		}

		Context 'Output' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'returns the session base uri' {

				$response.BaseURI | Should -Be 'https://radiantone.company.com'

			}

			It 'returns the authenticated user' {

				$response.User | Should -Be 'uid=testuser,ou=globalusers,cn=config'

			}

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.Session'

			}

			It 'returns a copy of the session' {

				$response.BaseURI = 'https://changed.company.com'
				$Script:psRadiantOneSession.BaseURI | Should -Be 'https://radiantone.company.com'

			}

		}

	}

}
