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

		BeforeAll {

			function New-Response {
				param($Disposition)
				[pscustomobject]@{ Headers = @{ 'Content-Disposition' = $Disposition } }
			}

		}

		It 'reads a plain file name' {

			Get-R1DownloadFileName -Response (New-Response 'attachment; filename=radiantone-datasources-export.zip') |
				Should -Be 'radiantone-datasources-export.zip'

		}

		It 'reads a quoted file name' {

			Get-R1DownloadFileName -Response (New-Response 'attachment; filename="quoted name.zip"') |
				Should -Be 'quoted name.zip'

		}

		It 'prefers the extended form, decoding it' {

			Get-R1DownloadFileName -Response (New-Response "attachment; filename=plain.zip; filename*=UTF-8''encoded%20name.zip") |
				Should -Be 'encoded name.zip'

		}

		It 'reads a header value held as a collection' {

			$Response = [pscustomobject]@{ Headers = @{ 'Content-Disposition' = [string[]]@('attachment; filename=first.zip') } }

			Get-R1DownloadFileName -Response $Response | Should -Be 'first.zip'

		}

		It 'finds the header whatever its case' {

			$Response = [pscustomobject]@{ Headers = @{ 'content-disposition' = 'attachment; filename=lower.zip' } }

			Get-R1DownloadFileName -Response $Response | Should -Be 'lower.zip'

		}

		It 'discards a path given with the name' -TestCases @(
			@{ Disposition = 'attachment; filename="../../evil.zip"' }
			@{ Disposition = 'attachment; filename="..\..\evil.zip"' }
			@{ Disposition = 'attachment; filename="/etc/evil.zip"' }
		) {

			Get-R1DownloadFileName -Response (New-Response $Disposition) | Should -Be 'evil.zip'

		}

		It 'returns nothing for a name which cannot name a file' -TestCases @(
			@{ Disposition = 'attachment; filename=".."' }
			@{ Disposition = 'attachment; filename="folder/"' }
			@{ Disposition = 'attachment; filename="bad|name.zip"' }
			@{ Disposition = 'attachment' }
		) {

			Get-R1DownloadFileName -Response (New-Response $Disposition) | Should -BeNullOrEmpty

		}

		It 'returns nothing when the response has no such header' {

			Get-R1DownloadFileName -Response ([pscustomobject]@{ Headers = @{ } }) | Should -BeNullOrEmpty

		}

	}

}
