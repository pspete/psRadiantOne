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

		Context 'Windows' -Skip:([System.Environment]::OSVersion.Platform -ne 'Win32NT') {

			It 'reads the location of a moved Downloads folder from the shell folder settings' {

				Mock Get-ItemProperty -MockWith {
					[pscustomobject]@{ '{374DE290-123F-4565-9164-39C4925E467B}' = '%SystemDrive%\Moved\Downloads' }
				}

				Get-R1DownloadPath | Should -Be ([System.Environment]::ExpandEnvironmentVariables('%SystemDrive%\Moved\Downloads'))

			}

			It 'falls back to the home directory when the setting cannot be read' {

				Mock Get-ItemProperty -MockWith { }

				Get-R1DownloadPath | Should -Be (Join-Path -Path $HOME -ChildPath 'Downloads')

			}

		}

	}

}
