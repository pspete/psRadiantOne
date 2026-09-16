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

			#A status code outside the 2xx range keeps the response out of Get-R1Response, whose
			#parameter is typed to a WebResponseObject these tests have no need to construct
			Mock Invoke-WebRequest -MockWith {
				[pscustomobject]@{ 'StatusCode' = 999 }
			}

			#Global process state - captured so a test cannot leak a protocol change into the session
			$Script:OriginalSecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol

		}

		AfterEach {

			[System.Net.ServicePointManager]::SecurityProtocol = $Script:OriginalSecurityProtocol

		}

		Context 'TLS' {

			It 'does not pin a tls protocol by default' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					-not $PSBoundParameters.ContainsKey('SslProtocol')

				} -Times 1 -Exactly -Scope It

			}

			It 'passes a specified tls protocol through to the request' -Skip:(-not $IsCoreCLR) {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET -SslProtocol 'Tls12'

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					$SslProtocol -eq 'Tls12'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send SslProtocol to windows powershell, which has no such parameter' -Skip:($IsCoreCLR) {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET -SslProtocol 'Tls12'

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					-not $PSBoundParameters.ContainsKey('SslProtocol')

				} -Times 1 -Exactly -Scope It

			}

			It 'leaves a SystemDefault security protocol untouched' {

				[System.Net.ServicePointManager]::SecurityProtocol = 0

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				[int][System.Net.ServicePointManager]::SecurityProtocol | Should -Be 0

			}

			It 'adds tls12 to an explicit legacy protocol' -Skip:($IsCoreCLR) {

				[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				([System.Net.ServicePointManager]::SecurityProtocol).HasFlag([Net.SecurityProtocolType]::Tls12) | Should -BeTrue

			}

			It 'preserves the protocols already permitted when adding tls12' -Skip:($IsCoreCLR) {

				[System.Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				$Result = [System.Net.ServicePointManager]::SecurityProtocol
				$Result.HasFlag([Net.SecurityProtocolType]::Tls) | Should -BeTrue
				$Result.HasFlag([Net.SecurityProtocolType]::Tls11) | Should -BeTrue
				$Result.HasFlag([Net.SecurityProtocolType]::Tls12) | Should -BeTrue

			}

		}

		Context 'Redirection' {

			#The API answers a create with 201 Created and a Location header naming an internal
			#http host. Without this, PowerShell rejects the response of a request which has
			#already succeeded.
			It 'permits the insecure redirect target the api returns from a create' -Skip:(-not $Script:AllowInsecureRedirectSupported) {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/directory-browser-service' -Method POST -Body '{}'

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					$AllowInsecureRedirect -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send AllowInsecureRedirect where the parameter does not exist' -Skip:($Script:AllowInsecureRedirectSupported) {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					-not $PSBoundParameters.ContainsKey('AllowInsecureRedirect')

				} -Times 1 -Exactly -Scope It

			}

			#PowerShell would otherwise carry the bearer token to the redirect target, which the
			#api names as a plain http host.
			It 'never preserves authorization across a redirect' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					-not $PSBoundParameters.ContainsKey('PreserveAuthorizationOnRedirect')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Version' {

			It 'records the deployment version reported in the response header' {

				Mock Invoke-WebRequest -MockWith {
					[pscustomobject]@{
						'StatusCode' = 999
						'Headers'    = @{ 'x-radiantone-iddm-version' = @('8.5.3') }
					}
				}

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				$Script:psRadiantOneSession.Version | Should -Be '8.5.3'

			}

			It 'leaves the recorded version alone when a response does not report one' {

				$Script:psRadiantOneSession.Version = '8.5.3'

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				$Script:psRadiantOneSession.Version | Should -Be '8.5.3'

			}

		}

		Context 'LastCommandResults' {

			BeforeEach {

				Mock Invoke-WebRequest -MockWith {
					[pscustomobject]@{
						'StatusCode'        = 999
						'StatusDescription' = 'Testing'
						'Headers'           = @{ 'x-trace-id' = @('abc123') }
						'Content'           = '{"authenticated":true,"token":"a.real.token"}'
					}
				}

			}

			It 'records what the api answered' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				$Script:psRadiantOneSession.LastCommandResults.StatusCode | Should -Be 999
				$Script:psRadiantOneSession.LastCommandResults.StatusDescription | Should -Be 'Testing'
				$Script:psRadiantOneSession.LastCommandResults.Headers | Should -Not -BeNullOrEmpty

			}

			#A login or token refresh response is a bearer token, and the session object is printed
			#by Get-R1Session.
			It 'masks a token in the recorded content' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				$Script:psRadiantOneSession.LastCommandResults.Content | Should -Not -Match 'a\.real\.token'
				$Script:psRadiantOneSession.LastCommandResults.Content | Should -Match '\*\*\*\*\*\*'

			}

			It 'keeps the rest of the content readable' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				$Script:psRadiantOneSession.LastCommandResults.Content | Should -Match '"authenticated":true'

			}

			#Hide-SecretValue matches a named property, so it cannot mask a body which is itself
			#the secret.
			It 'withholds the content of a response which is itself a secret' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/authentication-service/access_tokens' -Method POST -SecretResponse

				$Script:psRadiantOneSession.LastCommandResults.Content | Should -Be '******'
				$Script:psRadiantOneSession.LastCommandResults.StatusCode | Should -Be 999

			}

			It 'does not send SecretResponse to the web request' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET -SecretResponse

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					-not $PSBoundParameters.ContainsKey('SecretResponse')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Download' {

			BeforeEach {

				Mock Invoke-WebRequest -MockWith {
					[pscustomobject]@{
						'StatusCode' = 200
						'Headers'    = @{ 'Content-Disposition' = 'attachment; filename=export.zip' }
						'Content'    = [byte[]](80, 75, 3, 4)
					}
				}

			}

			It 'asks for the response when writing to a file' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET -OutFile (Join-Path $TestDrive 'export.zip')

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					$PassThru -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'returns the response rather than its content' {

				$Result = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET -OutFile (Join-Path $TestDrive 'export.zip')

				$Result.Headers['Content-Disposition'] | Should -Be 'attachment; filename=export.zip'

			}

			It 'does not ask for the response otherwise' {

				Mock Invoke-WebRequest -MockWith {
					[pscustomobject]@{ 'StatusCode' = 999 }
				}

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					-not $PassThru

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Request' {

			It 'sends the session token as a bearer token when no websession carries it' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					$Headers['Authorization'] -eq 'Bearer SomeToken'

				} -Times 1 -Exactly -Scope It

			}

			#The websession is sent with every request and holds the token already, so repeating it
			#in a header of its own achieves nothing.
			It 'does not repeat the token in a header when a websession carries it' {

				$Script:psRadiantOneSession.WebSession = [Microsoft.PowerShell.Commands.WebRequestSession]::new()
				$Script:psRadiantOneSession.WebSession.Headers['Authorization'] = 'Bearer SomeToken'

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					-not $Headers.ContainsKey('Authorization')

				} -Times 1 -Exactly -Scope It

			}

			It 'keeps an authorization header supplied by the caller when a websession exists' {

				$Script:psRadiantOneSession.WebSession = [Microsoft.PowerShell.Commands.WebRequestSession]::new()
				$Script:psRadiantOneSession.WebSession.Headers['Authorization'] = 'Bearer SomeToken'

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET -Headers @{ Authorization = 'Basic c29tZXRoaW5n' }

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					$Headers['Authorization'] -eq 'Basic c29tZXRoaW5n'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not replace an authorization header supplied by the caller' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET -Headers @{ Authorization = 'Basic c29tZXRoaW5n' }

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					$Headers['Authorization'] -eq 'Basic c29tZXRoaW5n'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a string body as utf8 bytes' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method POST -Body '{"name":"value"}'

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					$Body -is [byte[]]

				} -Times 1 -Exactly -Scope It

			}

			It 'defaults to a json content type' {

				$null = Invoke-R1RestMethod -Uri 'https://radiantone.company.com/settings-service' -Method GET

				Should -Invoke -CommandName Invoke-WebRequest -ParameterFilter {

					$ContentType -eq 'application/json'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
