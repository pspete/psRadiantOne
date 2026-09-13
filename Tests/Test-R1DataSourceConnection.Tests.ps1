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
				[pscustomobject]@{ 'isSuccessful' = $true; 'message' = 'Connected' }
			}

			$DataSource = [pscustomobject]@{ 'name' = 'opendj'; 'category' = 'ldap'; 'type' = 'Generic LDAP'; 'host' = 'ldap.example.com'; 'port' = 389 }

			$response = Test-R1DataSourceConnection -DataSource $DataSource

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/data_sources/test_connection') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the data source as the body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Decoded.name -eq 'opendj'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so a password cannot be captured' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			It 'asks the server to use the stored credentials when told to' {

				$DataSource = [pscustomobject]@{ 'name' = 'opendj' }

				$null = Test-R1DataSourceConnection -DataSource $DataSource -useExistingCredentials

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -cmatch 'useExistingCredentials=true' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.ConnectionTestResult'

			}

		}

	}

}
