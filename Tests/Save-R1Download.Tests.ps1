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
				BaseURI     = 'https://radiantone.company.com'
				Token       = 'SomeToken'
				TokenExpiry = $null
				WebSession  = $null
			}
			New-Variable -Name psRadiantOneSession -Value $psRadiantOneSession -Scope Script -Force

			$Target = New-Item -Path (Join-Path $TestDrive ([guid]::NewGuid())) -ItemType Directory

			Mock Invoke-R1RestMethod -MockWith {
				[System.IO.File]::WriteAllBytes($OutFile, [byte[]](80, 75, 3, 4, 200, 0))
				[pscustomobject]@{ Headers = @{ 'Content-Disposition' = 'attachment; filename=from-response.zip' } }
			}

			$Request = @{
				Uri         = 'https://radiantone.company.com/data-catalog-service/data_sources/export'
				Method      = 'GET'
				DefaultName = 'default.zip'
			}

		}

		It 'names the file as the response names it when given a directory' {

			$File = Save-R1Download @Request -Path $Target.FullName

			$File.FullName | Should -Be (Join-Path $Target.FullName 'from-response.zip')

		}

		It 'uses the name a full file path ends in, whatever the response gives' {

			$File = Save-R1Download @Request -Path (Join-Path $Target.FullName 'mine.zip')

			$File.Name | Should -Be 'mine.zip'

		}

		It 'saves to the downloads directory when given no path' {

			Mock Get-R1DownloadPath -MockWith { $Target.FullName }

			$File = Save-R1Download @Request

			$File.DirectoryName | Should -Be $Target.FullName

		}

		It 'uses the default name when the response gives none' {

			Mock Invoke-R1RestMethod -MockWith {
				[System.IO.File]::WriteAllBytes($OutFile, [byte[]](80, 75, 3, 4, 200, 0))
				[pscustomobject]@{ Headers = @{ } }
			}

			$File = Save-R1Download @Request -Path $Target.FullName

			$File.Name | Should -Be 'default.zip'

		}

		It 'writes the response straight to a file in the destination directory' {

			$null = Save-R1Download @Request -Path $Target.FullName

			Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

				(Split-Path -Path $OutFile -Parent) -eq $Target.FullName

			} -Times 1 -Exactly -Scope It

		}

		It 'sends the body' {

			$null = Save-R1Download @Request -Path $Target.FullName -Body '{"files":["a"]}'

			Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

				$Body -eq '{"files":["a"]}'

			} -Times 1 -Exactly -Scope It

		}

		It 'keeps the bytes as they were downloaded' {

			$File = Save-R1Download @Request -Path $Target.FullName

			[System.IO.File]::ReadAllBytes($File.FullName) | Should -Be ([byte[]](80, 75, 3, 4, 200, 0))

		}

		It 'replaces a file of the same name' {

			Set-Content -Path (Join-Path $Target.FullName 'from-response.zip') -Value 'older'

			$File = Save-R1Download @Request -Path $Target.FullName

			$File.Length | Should -Be 6

		}

		It 'returns the file' {

			Save-R1Download @Request -Path $Target.FullName | Should -BeOfType [System.IO.FileInfo]

		}

		It 'leaves nothing behind when the download fails' {

			Mock Invoke-R1RestMethod -MockWith {
				[System.IO.File]::WriteAllBytes($OutFile, [byte[]](80, 75))
				throw 'simulated failure'
			}

			{ Save-R1Download @Request -Path $Target.FullName } | Should -Throw 'simulated failure'

			@(Get-ChildItem -Path $Target.FullName).Count | Should -Be 0

		}

		It 'refuses a directory which does not exist' {

			{ Save-R1Download @Request -Path (Join-Path $TestDrive 'missing\file.zip') } |
				Should -Throw -ErrorId 'psRadiantOne.DirectoryNotFound,Save-R1Download'

		}

	}

}
