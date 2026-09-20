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

			Remove-R1DataSourcePlugin -pluginName 'acs' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/plugins/acs')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'The API answers a successful removal with an error' {

			It 'does not throw when the plugin is gone from the listing' {

				Mock Invoke-R1RestMethod -MockWith { throw 'The API returned HTTP 500 Internal Server Error with no error details.' }
				Mock Get-R1DataSourcePlugin -MockWith { @() }

				{ Remove-R1DataSourcePlugin -pluginName 'acs' -Confirm:$false -WarningAction SilentlyContinue } | Should -Not -Throw

			}

			It 'warns rather than throwing when the plugin is gone from the listing' {

				Mock Invoke-R1RestMethod -MockWith { throw 'The API returned HTTP 500 Internal Server Error with no error details.' }
				Mock Get-R1DataSourcePlugin -MockWith { @() }

				Remove-R1DataSourcePlugin -pluginName 'acs' -Confirm:$false -WarningVariable Warned -WarningAction SilentlyContinue

				$Warned | Should -Not -BeNullOrEmpty

			}

			It 'throws when the plugin is still listed' {

				Mock Invoke-R1RestMethod -MockWith { throw 'The API returned HTTP 500 Internal Server Error with no error details.' }
				Mock Get-R1DataSourcePlugin -MockWith { @([pscustomobject]@{ name = 'acs' }) }

				{ Remove-R1DataSourcePlugin -pluginName 'acs' -Confirm:$false } | Should -Throw

			}

		}

	}

}
