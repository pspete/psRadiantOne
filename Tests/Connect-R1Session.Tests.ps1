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
					'authenticated' = $true
					'token'         = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InVpZD10ZXN0dXNlcixvdT1nbG9iYWx1c2Vycyxjbj1jb25maWciLCJleHAiOjE4OTM0NTYwMDAsInByaXZpbGVnZXMiOlsiUk9MRV9DT05GSUdfUkVBRCIsIlJPTEVfQ09ORklHX1dSSVRFIl0sIm9yZ2FuaXphdGlvbiI6IlRlc3QgT3JnIiwic2VydmVyIjoiaHR0cHM6Ly9jcC50ZXN0LmNvbSJ9.signature'
				}
			}

			$Credential = New-Object System.Management.Automation.PSCredential('testuser', ('P@ssword' | ConvertTo-SecureString -AsPlainText -Force))
			$response = Connect-R1Session -BaseURI 'https://radiantone.company.com' -Credential $Credential
		}

		Context 'WebSession' {

			BeforeEach {

				#Stand in for Invoke-R1RestMethod populating the module scope WebSession from the
				#login request, whose Authorization header is the Basic credential.
				Mock Invoke-R1RestMethod -MockWith {
					$Script:psRadiantOneSession.WebSession = [Microsoft.PowerShell.Commands.WebRequestSession]::new()
					$Script:psRadiantOneSession.WebSession.Headers['Authorization'] = 'Basic dGVzdHVzZXI6UEBzc3dvcmQ='
					[pscustomobject]@{ 'authenticated' = $true; 'token' = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InVpZD10ZXN0dXNlcixvdT1nbG9iYWx1c2Vycyxjbj1jb25maWciLCJleHAiOjE4OTM0NTYwMDAsInByaXZpbGVnZXMiOlsiUk9MRV9DT05GSUdfUkVBRCIsIlJPTEVfQ09ORklHX1dSSVRFIl0sIm9yZ2FuaXphdGlvbiI6IlRlc3QgT3JnIiwic2VydmVyIjoiaHR0cHM6Ly9jcC50ZXN0LmNvbSJ9.signature' }
				}

				$Credential = New-Object System.Management.Automation.PSCredential('testuser', ('P@ssword' | ConvertTo-SecureString -AsPlainText -Force))
				$null = Connect-R1Session -BaseURI 'https://radiantone.company.com' -Credential $Credential

			}

			It 'requests a websession for the caller to send their own requests with' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					-not ([string]::IsNullOrEmpty($SessionVariable))

				} -Scope It

			}

			It 'makes the websession available in the session object' {

				(Get-R1Session).WebSession | Should -Not -BeNullOrEmpty

			}

			#A websession keeps the Authorization header of the request which created it, and the
			#login request authenticates with Basic.
			It 'does not leave the basic credential in the websession' {

				(Get-R1Session).WebSession.Headers['Authorization'] | Should -Not -Match '^Basic'

			}

			It 'carries the bearer token in the websession' {

				(Get-R1Session).WebSession.Headers['Authorization'] | Should -Be 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InVpZD10ZXN0dXNlcixvdT1nbG9iYWx1c2Vycyxjbj1jb25maWciLCJleHAiOjE4OTM0NTYwMDAsInByaXZpbGVnZXMiOlsiUk9MRV9DT05GSUdfUkVBRCIsIlJPTEVfQ09ORklHX1dSSVRFIl0sIm9yZ2FuaXphdGlvbiI6IlRlc3QgT3JnIiwic2VydmVyIjoiaHR0cHM6Ly9jcC50ZXN0LmNvbSJ9.signature'

			}

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/v2/login'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'sends basic authorization header' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Headers['Authorization'] -match '^Basic '

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expected base64 encoded credentials' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Headers['Authorization'] -eq "Basic $([System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('testuser:P@ssword')))"

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Failure' {

			It 'names the url which was called when login fails' {

				Mock Invoke-R1RestMethod -MockWith { throw 'Not Found' }

				$Credential = New-Object System.Management.Automation.PSCredential('testuser', ('P@ssword' | ConvertTo-SecureString -AsPlainText -Force))

				{ Connect-R1Session -BaseURI 'https://radiantone.company.com' -Credential $Credential } |
					Should -Throw -ExpectedMessage '*https://radiantone.company.com/authentication-service/v2/login*'

			}

			It 'leaves no partial session behind when login fails' {

				Mock Invoke-R1RestMethod -MockWith { throw 'Not Found' }

				$Credential = New-Object System.Management.Automation.PSCredential('testuser', ('P@ssword' | ConvertTo-SecureString -AsPlainText -Force))

				try { Connect-R1Session -BaseURI 'https://radiantone.company.com' -Credential $Credential } catch { }

				$Script:psRadiantOneSession.BaseURI | Should -BeNullOrEmpty

			}

		}

		Context 'Output' {

			It 'sets the session token' {

				$Script:psRadiantOneSession.Token | Should -Be 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InVpZD10ZXN0dXNlcixvdT1nbG9iYWx1c2Vycyxjbj1jb25maWciLCJleHAiOjE4OTM0NTYwMDAsInByaXZpbGVnZXMiOlsiUk9MRV9DT05GSUdfUkVBRCIsIlJPTEVfQ09ORklHX1dSSVRFIl0sIm9yZ2FuaXphdGlvbiI6IlRlc3QgT3JnIiwic2VydmVyIjoiaHR0cHM6Ly9jcC50ZXN0LmNvbSJ9.signature'

			}

			It 'sets the session user from the token claims' {

				$Script:psRadiantOneSession.User | Should -Be 'uid=testuser,ou=globalusers,cn=config'

			}

			It 'sets the session privileges from the token claims' {

				$Script:psRadiantOneSession.Privileges | Should -Contain 'ROLE_CONFIG_READ'

			}

			It 'sets the session base uri' {

				$Script:psRadiantOneSession.BaseURI | Should -Be 'https://radiantone.company.com'

			}

			It 'returns no output on successful authentication' {

				$response | Should -BeNullOrEmpty

			}

			It 'returns password reset information when the password is expired' {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'authenticated' = $false
						'passwordReset' = [pscustomobject]@{
							'allowed'                = $true
							'resetToken'             = 'a1B2c3D4'
							'requireCurrentPassword' = $true
						}
					}
				}

				$Credential = New-Object System.Management.Automation.PSCredential('testuser', ('P@ssword' | ConvertTo-SecureString -AsPlainText -Force))
				$result = Connect-R1Session -BaseURI 'https://radiantone.company.com' -Credential $Credential -WarningAction SilentlyContinue

				$result.resetToken | Should -Be 'a1B2c3D4'

			}

			It 'establishes no token when the password is expired' {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'authenticated' = $false
						'passwordReset' = [pscustomobject]@{ 'allowed' = $true; 'resetToken' = 'a1B2c3D4' }
					}
				}

				$Credential = New-Object System.Management.Automation.PSCredential('testuser', ('P@ssword' | ConvertTo-SecureString -AsPlainText -Force))
				$null = Connect-R1Session -BaseURI 'https://radiantone.company.com' -Credential $Credential -WarningAction SilentlyContinue

				$Script:psRadiantOneSession.Token | Should -BeNullOrEmpty

			}

		}

	}

}
