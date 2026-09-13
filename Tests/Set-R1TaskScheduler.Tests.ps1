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
					'defaultJvmParameters'     = '-server -Xms512m'
					'deleteTasksOlderThanDays' = 9
					'status'                   = 'RUNNING'
					'logLevel'                 = 'INFO'
					'taskLogLevel'             = 'INFO'
				}
			}

			$response = Set-R1TaskScheduler -deleteTasksOlderThanDays 30 -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/system-administration-service/task_scheduler')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current settings before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).deleteTasksOlderThanDays -eq 30

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves settings which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).defaultJvmParameters -eq '-server -Xms512m'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the properties the api reports but does not accept' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($null -eq $Decoded.status) -and ($null -eq $Decoded.logLevel) -and ($null -eq $Decoded.taskLogLevel)

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.TaskScheduler'

			}

		}

	}

}
