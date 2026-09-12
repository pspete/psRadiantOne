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

			Mock Invoke-R1RestMethod -MockWith { }

			New-R1OidcProvider -configurationName 'SomeProvider' -providerName Custom -discoveryUrl 'https://idp.example.com/.well-known/openid-configuration' -authorizationEndpointUri 'https://idp.example.com/auth' -tokenEndpointUri 'https://idp.example.com/token' -clientId 'client-123' -requestedScopes openid -oidcToFidUserMappings 'uid=$sub' -clientSecret ('s3cret' | ConvertTo-SecureString -AsPlainText -Force) -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/oidc_providers')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends the request body as UTF8 bytes, since it carries a client secret' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			It 'sends expected request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$d = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($d.configurationName -eq 'SomeProvider') -and ($d.clientSecret -eq 's3cret')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single scope as an array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					@(([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).requestedScopes).Count -eq 1

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
