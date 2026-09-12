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
					'logSettingsComponent'  = 'RadiantOne LDAP Access'
					'rolloverSize'          = '100MB'
					'archiveMaxFileCount'   = 10
					'integrityAssurance'    = $false
					'accessLogTextFormat'   = 'default'
					'textDestination'       = '/logs/access.log'
					'useIsoFormat'          = $true
					'timezone'              = 'UTC'
				}
			}

			$response = Get-R1LogSetting -component 'RadiantOne LDAP Access'

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/log_settings/RadiantOne%20LDAP%20Access')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'escapes the spaces in a component name' {

				Get-R1LogSetting -component 'Control Panel Context Builder Audit'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/settings-service/log_settings/Control%20Panel%20Context%20Builder%20Audit'

				} -Times 1 -Exactly -Scope It

			}

			It 'requests a data source component from its own path' {

				Get-R1LogSetting -dsName 'SomeDataSource'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/settings-service/log_settings/datasources/SomeDataSource'

				} -Times 1 -Exactly -Scope It

			}

			It 'requests a plugin component from its own path' {

				Get-R1LogSetting -pluginName 'SomePlugin'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/settings-service/log_settings/plugins/SomePlugin'

				} -Times 1 -Exactly -Scope It

			}

			It 'rejects a component name the api does not define' {

				{ Get-R1LogSetting -component 'Nonsense' } | Should -Throw

			}

		}

		Context 'Output' {

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.LogSettings'

			}

		}

	}

}
