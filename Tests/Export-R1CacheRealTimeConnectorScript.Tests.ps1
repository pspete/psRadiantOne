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

			Mock Save-R1Download -MockWith { }

			Export-R1CacheRealTimeConnectorScript -dn 'o=cache' -connectorId 'northwind_APP.EMPLOYEES' -action DECONFIGURE -Path 'C:\scripts'

		}

		Context 'Input' {

			It 'downloads the scripts for the action' {

				Should -Invoke -CommandName Save-R1Download -ParameterFilter {

					($Method -eq 'GET') -and ($Uri -eq 'https://radiantone.company.com/directory-namespace-service/caches/o%3Dcache/refresh/real_time_connectors/northwind_APP.EMPLOYEES/scripts/download?action=DECONFIGURE')

				} -Times 1 -Exactly -Scope It

			}

			It 'saves them where specified' {

				Should -Invoke -CommandName Save-R1Download -ParameterFilter { $Path -eq 'C:\scripts' } -Times 1 -Exactly -Scope It

			}

		}

	}

}
