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

			Mock Invoke-R1RestMethod -MockWith { @('line one', 'line two') }

		}

		Context 'Download' {

			It 'sends request to the logs endpoint' {

				$null = Get-R1TaskLog -id 'e4ef6b3e'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/system-administration-service/tasks/e4ef6b3e/logs')

				} -Times 1 -Exactly -Scope It

			}

			It 'returns every line' {

				$response = Get-R1TaskLog -id 'e4ef6b3e'

				@($response).Count | Should -Be 2

			}

			It 'does not set a timeout' {

				$null = Get-R1TaskLog -id 'e4ef6b3e'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { -not $PSBoundParameters.ContainsKey('TimeoutSec') } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Tail' {

			It 'sends request to the tail endpoint' {

				$null = Get-R1TaskLog -id 'e4ef6b3e' -Tail

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/system-administration-service/tasks/e4ef6b3e/logs/tail')

				} -Times 1 -Exactly -Scope It

			}

			It 'bounds the request with a timeout, because the endpoint does not close on its own' {

				$null = Get-R1TaskLog -id 'e4ef6b3e' -Tail

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $TimeoutSec -eq 30 } -Times 1 -Exactly -Scope It

			}

			It 'uses the specified timeout' {

				$null = Get-R1TaskLog -id 'e4ef6b3e' -Tail -TimeoutSec 5

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $TimeoutSec -eq 5 } -Times 1 -Exactly -Scope It

			}

		}

	}

}
