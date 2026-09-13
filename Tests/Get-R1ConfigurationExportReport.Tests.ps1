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
				[pscustomobject]@{ 'status' = 'SUCCESS'; 'revision' = 'a1b2c3' }
			}

		}

		Context 'All' {

			It 'sends request to the report list endpoint' {

				$null = Get-R1ConfigurationExportReport

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/configuration/export/auto/reports')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1ConfigurationExportReport

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.ConfigurationExportReport'

			}

		}

		Context 'Timestamp' {

			It 'sends the timestamp in the invariant format' {

				$null = Get-R1ConfigurationExportReport -timestamp ([datetime]::new(2026, 1, 30, 8, 30, 0, [System.DateTimeKind]::Utc))

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -match '2026-01-30T08%3A30%3A00\.000Z$'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
