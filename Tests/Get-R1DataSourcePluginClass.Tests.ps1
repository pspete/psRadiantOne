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

			Mock Invoke-R1RestMethod -MockWith { @('com.example.Acs', 'com.example.Other') }

		}

		Context 'Installed' {

			It 'sends request to the plugin endpoint' {

				$null = Get-R1DataSourcePluginClass -pluginName 'acs'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/plugins/acs/classes')

				} -Times 1 -Exactly -Scope It

			}

			It 'returns every class' {

				$response = Get-R1DataSourcePluginClass -pluginName 'acs'

				@($response).Count | Should -Be 2

			}

		}

		Context 'Import' {

			It 'sends request to the import endpoint' {

				$null = Get-R1DataSourcePluginClass -pluginName 'acs' -importId 'imp1'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/import/imp1/plugins/acs/classes')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
