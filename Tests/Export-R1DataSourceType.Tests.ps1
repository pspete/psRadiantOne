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

			Mock Save-R1Download -MockWith {
				$File = Join-Path -Path $(if ($Path) { $Path } else { $TestDrive }) -ChildPath $DefaultName
				[System.IO.File]::WriteAllBytes($File, [byte[]](80, 75, 3, 4, 200, 0))
				Get-Item -LiteralPath $File
			}

			$response = Export-R1DataSourceType -templates 'acsclient' -Path $TestDrive

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Save-R1Download -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/export') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the template names as an array property' {

				Should -Invoke -CommandName Save-R1Download -ParameterFilter {

					@(($Body | ConvertFrom-Json).templates).Count -eq 1

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'downloads to the specified path' {

				Should -Invoke -CommandName Save-R1Download -ParameterFilter {

					($Path -eq $TestDrive) -and ($DefaultName -eq 'templates.zip')

				} -Times 1 -Exactly -Scope It

			}

			It 'writes the archive into the specified directory' {

				Test-Path -Path (Join-Path $TestDrive 'templates.zip') | Should -BeTrue

			}

			It 'returns the file' {

				$response | Should -BeOfType [System.IO.FileInfo]

			}

		}

		Context 'Default path' {

			It 'leaves the location to the download when no path is given' {

				$null = Export-R1DataSourceType -templates 'acsclient'

				Should -Invoke -CommandName Save-R1Download -ParameterFilter {

					[string]::IsNullOrEmpty($Path)

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
