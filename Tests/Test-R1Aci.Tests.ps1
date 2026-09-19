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

			Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ aciString = 'SomeAciString'; parsable = $true } }

			$response = Test-R1Aci -aciString 'SomeAciString'

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/access_control/acis/validate_parsable')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the aci string itself as the request body of a GET' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'GET') -and ($Body -eq 'SomeAciString')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not json encode the aci string' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Body -notmatch '^"'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty TypeName -Unique | Should -Be 'psRadiantOne.Aci'

			}

		}

	}

}
