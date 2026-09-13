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

			Mock Invoke-R1RestMethod -MockWith { 'file-content' }

		}

		Context 'Single file' {

			BeforeEach {

				$response = Export-R1File -files '/conf/app.properties' -Path $TestDrive

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/file_manager/files/download') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'names the written file after the requested one' {

				$response.Name | Should -Be 'app.properties'

			}

			It 'returns the file' {

				$response | Should -BeOfType [System.IO.FileInfo]

			}

		}

		Context 'Several files' {

			It 'writes an archive when more than one file is requested' {

				$response = Export-R1File -files '/conf/one.txt', '/conf/two.txt' -Path $TestDrive

				$response.Name | Should -Be 'files.zip'

			}

			It 'sends every requested path' {

				$null = Export-R1File -files '/conf/one.txt', '/conf/two.txt' -Path $TestDrive

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					@(($Body | ConvertFrom-Json).files).Count -eq 2

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
