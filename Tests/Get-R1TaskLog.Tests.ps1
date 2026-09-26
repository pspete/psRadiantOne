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

			#The download endpoint answers with the whole log as one string, the tail endpoint with
			#an array of lines, whatever the definition says they share.
			Mock Invoke-R1RestMethod -MockWith { "line one`nline two`n" }

		}

		Context 'Download' {

			It 'sends request to the logs endpoint' {

				$null = Get-R1TaskLog -id 'e4ef6b3e'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/system-administration-service/tasks/e4ef6b3e/logs')

				} -Times 1 -Exactly -Scope It

			}

			It 'accepts the taskId a launched task reports' {

				$null = [pscustomobject]@{ taskId = 'e4ef6b3e' } | Get-R1TaskLog

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/system-administration-service/tasks/e4ef6b3e/logs')

				} -Times 1 -Exactly -Scope It

			}

			It 'returns the log as lines rather than one string' {

				$response = Get-R1TaskLog -id 'e4ef6b3e'

				@($response).Count | Should -Be 2
				$response[0] | Should -Be 'line one'

			}

			It 'does not return a trailing empty line' {

				$response = Get-R1TaskLog -id 'e4ef6b3e'

				$response[-1] | Should -Be 'line two'

			}

			It 'does not set a timeout' {

				$null = Get-R1TaskLog -id 'e4ef6b3e'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { -not $PSBoundParameters.ContainsKey('TimeoutSec') } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Tail' {

			#Asked without numberOfLines the endpoint follows the log and never closes the response,
			#so the parameter is mandatory and selects this set on its own.
			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith { @('line one', 'line two') }

			}

			It 'returns the lines the api sent, untouched' {

				$response = Get-R1TaskLog -id 'e4ef6b3e' -numberOfLines 2

				@($response).Count | Should -Be 2
				$response[0] | Should -Be 'line one'

			}

			It 'sends request to the tail endpoint, asking for the number of lines' {

				$null = Get-R1TaskLog -id 'e4ef6b3e' -numberOfLines 500

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/system-administration-service/tasks/e4ef6b3e/logs/tail?numberOfLines=500')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not set a timeout' {

				$null = Get-R1TaskLog -id 'e4ef6b3e' -numberOfLines 15

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { -not $PSBoundParameters.ContainsKey('TimeoutSec') } -Times 1 -Exactly -Scope It

			}

			It 'rejects a line count outside the range the api accepts' {

				{ Get-R1TaskLog -id 'e4ef6b3e' -numberOfLines 2001 } | Should -Throw

			}

		}

	}

}
