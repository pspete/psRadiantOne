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
					'configurationName'          = 'SomeProvider'
					'providerName'               = 'Custom'
					'enabled'                    = $true
					'discoveryUrl'               = 'https://idp.example.com/.well-known/openid-configuration'
					'authorizationEndpointUri'   = 'https://idp.example.com/auth'
					'tokenEndpointUri'           = 'https://idp.example.com/token'
					'clientId'                   = 'client-123'
					'clientAuthenticationMethod' = 'CLIENT_SECRET_POST'
					'oidcToFidUserMappings'      = @('uid=$sub')
					'requestedScopes'            = @('openid', 'profile')
				}
			}

			Set-R1OidcProvider -configurationName 'SomeProvider' -enabled $false -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/settings-service/oidc_providers/SomeProvider')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'retrieves the provider before updating it' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$d = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($d.clientId -eq 'client-123') -and (@($d.requestedScopes).Count -eq 2)

				} -Times 1 -Exactly -Scope It

			}

			It 'omits the client secret when it is not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$null -eq ([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).clientSecret

				} -Times 1 -Exactly -Scope It

			}

			It 'sends useExistingCredentials as a query parameter when specified' {

				Set-R1OidcProvider -configurationName 'SomeProvider' -useExistingCredentials -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/settings-service/oidc_providers/SomeProvider?useExistingCredentials=true')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
