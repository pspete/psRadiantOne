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

			Set-R1Task -id 'e4ef6b3e' -executionInterval '00h 10m 00s' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/system-administration-service/tasks/e4ef6b3e')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the task before updating it' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).executionInterval -eq '00h 10m 00s'

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.jvmParameters -eq '-Xms1024m') -and ($Decoded.name -eq 'JStackMonitorTask')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the task id in the body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).id -eq 'e4ef6b3e'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the properties the api reports but does not accept' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($null -eq $Decoded.status) -and ($null -eq $Decoded.recurrent) -and ($null -eq $Decoded.logs)

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Non-recurrent task' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'id'                = 'a1477b99'
						'name'              = 'Cache Init for o=CapHR'
						'recurrent'         = $false
						'dedicatedJvm'      = $true
						'jvmParameters'     = $null
						'executionInterval' = 'N_A'
						'status'            = 'FINISHED'
						'logs'              = @('log1', 'log2')
					}
				}

				Set-R1Task -id 'a1477b99' -Confirm:$false

			}

			It 'does not send the N_A sentinel back as executionInterval' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$null -eq ($Body | ConvertFrom-Json).executionInterval

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
