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
				[pscustomobject]@{ 'token' = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InVpZD10ZXN0dXNlcixvdT1nbG9iYWx1c2Vycyxjbj1jb25maWciLCJleHAiOjE4OTM0NTYwMDAsInByaXZpbGVnZXMiOlsiUk9MRV9DT05GSUdfUkVBRCIsIlJPTEVfQ09ORklHX1dSSVRFIl0sIm9yZ2FuaXphdGlvbiI6IlRlc3QgT3JnIiwic2VydmVyIjoiaHR0cHM6Ly9jcC50ZXN0LmNvbSJ9.signature' }
			}

			Update-R1AuthToken -Confirm:$false
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/authToken/refresh'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'updates the session token' {

				$Script:psRadiantOneSession.Token | Should -Be 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InVpZD10ZXN0dXNlcixvdT1nbG9iYWx1c2Vycyxjbj1jb25maWciLCJleHAiOjE4OTM0NTYwMDAsInByaXZpbGVnZXMiOlsiUk9MRV9DT05GSUdfUkVBRCIsIlJPTEVfQ09ORklHX1dSSVRFIl0sIm9yZ2FuaXphdGlvbiI6IlRlc3QgT3JnIiwic2VydmVyIjoiaHR0cHM6Ly9jcC50ZXN0LmNvbSJ9.signature'

			}

			It 'updates the session token expiry from the token claims' {

				$Script:psRadiantOneSession.TokenExpiry | Should -Not -BeNullOrEmpty

			}

		}

	}

}
