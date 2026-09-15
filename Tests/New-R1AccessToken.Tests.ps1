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

			Mock Invoke-R1RestMethod -MockWith { 'SomeTokenValue' }

			$response = New-R1AccessToken -name 'Prod Service Account' -apiType CONFIG -Confirm:$false
		}

		Context 'Input' {

			#The response is the access token itself, which is a long lived credential, so it must
			#not be recorded as the result of the last command.
			It 'withholds the response from the session object' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$SecretResponse -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/access_tokens'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends expected request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.name -eq 'Prod Service Account') -and ($Decoded.apiType -eq 'CONFIG')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expiresOn in expected format' {

				New-R1AccessToken -name 'Token' -apiType REST -expiresOn (Get-Date '2030-01-02T03:04:05Z').ToUniversalTime() -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					#ConvertFrom-Json would rehydrate the value to a [datetime], so match the raw json
					$Body -match '"expiresOn"\s*:\s*"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z"'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends expiresOn in the format the control panel sends' {

				New-R1AccessToken -name 'Token' -apiType REST -expiresOn ([datetime]'2027-09-12T17:42:49.987Z') -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					#ConvertFrom-Json would rehydrate the value to a [datetime], so match the raw json
					$Body -match '"expiresOn"\s*:\s*"2027-09-12T17:42:49\.987Z"'

				} -Times 1 -Exactly -Scope It

			}

			It 'formats expiresOn independently of the current culture' {

				$Original = [System.Threading.Thread]::CurrentThread.CurrentCulture

				try {

					#Finnish uses '.' as its time separator, which would corrupt a colon in the format
					[System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]::GetCultureInfo('fi-FI')

					New-R1AccessToken -name 'Token' -apiType REST -expiresOn ([datetime]'2027-09-12T17:42:49.987Z') -Confirm:$false

					Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

						$Body -match '"expiresOn"\s*:\s*"2027-09-12T17:42:49\.987Z"'

					} -Times 1 -Exactly -Scope It

				} finally {

					[System.Threading.Thread]::CurrentThread.CurrentCulture = $Original

				}

			}

		}

		Context 'Output' {

			It 'returns the token value' {

				$response | Should -Be 'SomeTokenValue'

			}

		}

	}

}
