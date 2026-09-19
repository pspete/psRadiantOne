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

			Restore-R1Store -dn 'o=store' -backupId '2026-09-19_17-50-33' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dstore/store/restore')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the backup id' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).backupId -eq '2026-09-19_17-50-33'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Pipeline' {

			BeforeEach {

				[pscustomobject]@{ 'id' = '2026-09-18_09-00-00'; 'label' = '09/18/2026 09:00:00' } | Restore-R1Store -dn 'o=store' -Confirm:$false

			}

			It 'takes the backup id from a listed backup' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).backupId -eq '2026-09-18_09-00-00'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
