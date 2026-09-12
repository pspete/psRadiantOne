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
				[pscustomobject]@{ 'Prop' = 'Value' }
			}

			Disconnect-R1Session -Confirm:$false
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/authToken/SomeToken'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Revocation failure' {

			It 'warns when the token cannot be revoked' {

				#BeforeEach has already disconnected, so restore a session to act on
				$Script:psRadiantOneSession.BaseURI = 'https://radiantone.company.com'
				$Script:psRadiantOneSession.Token = 'SomeToken'

				Mock Invoke-R1RestMethod -MockWith { throw 'Forbidden' }

				$Warnings = $( Disconnect-R1Session -Confirm:$false ) 3>&1

				$Warnings | Should -Not -BeNullOrEmpty

			}

			It 'clears the local session even when revocation fails' {

				#BeforeEach has already disconnected, so restore a session to act on
				$Script:psRadiantOneSession.BaseURI = 'https://radiantone.company.com'
				$Script:psRadiantOneSession.Token = 'SomeToken'

				Mock Invoke-R1RestMethod -MockWith { throw 'Forbidden' }

				Disconnect-R1Session -Confirm:$false -WarningAction SilentlyContinue

				$Script:psRadiantOneSession.Token | Should -BeNullOrEmpty
				$Script:psRadiantOneSession.BaseURI | Should -BeNullOrEmpty

			}

		}

		Context 'Output' {

			It 'clears the session token' {

				$Script:psRadiantOneSession.Token | Should -BeNullOrEmpty

			}

			It 'clears the session base uri' {

				$Script:psRadiantOneSession.BaseURI | Should -BeNullOrEmpty

			}

		}

	}

}
