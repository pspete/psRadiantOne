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
					'id'                = 'e4ef6b3e'
					'name'              = 'JStackMonitorTask'
					'recurrent'         = $true
					'dedicatedJvm'      = $false
					'jvmParameters'     = '-Xms1024m'
					'executionInterval' = '00h 00m 05s'
					'status'            = 'SCHEDULED'
					'logs'              = @('log1', 'log2')
				}
			}

		}

		Context 'All' {

			It 'sends request to the collection endpoint' {

				$null = Get-R1Task

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/system-administration-service/tasks')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				$null = Get-R1Task

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Id' {

			It 'sends request to the named endpoint' {

				$null = Get-R1Task -id 'e4ef6b3e'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/system-administration-service/tasks/e4ef6b3e')

				} -Times 1 -Exactly -Scope It

			}

			It 'accepts the taskId a launched task reports' {

				$null = [pscustomobject]@{ taskId = 'e4ef6b3e' } | Get-R1Task

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/system-administration-service/tasks/e4ef6b3e')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1Task -id 'e4ef6b3e'

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.Task'

			}

		}

	}

}
