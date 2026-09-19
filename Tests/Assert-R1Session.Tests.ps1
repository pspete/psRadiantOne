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
				BaseURI            = $null
				User               = $null
				Token              = $null
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

		}

		Context 'No session' {

			It 'throws, naming the command to run' {

				{ Assert-R1Session } | Should -Throw '*Run Connect-R1Session first*'

			}

			It 'stops the calling command before it sends its request' {

				{ Get-R1Cache } | Should -Throw
				Should -Invoke -CommandName Invoke-R1RestMethod -Times 0 -Exactly -Scope It

			}

		}

		Context 'No token' {

			BeforeEach {

				$psRadiantOneSession['BaseURI'] = 'https://radiantone.company.com'
				New-Variable -Name psRadiantOneSession -Value $psRadiantOneSession -Scope Script -Force

			}

			It 'throws when a token is required' {

				{ Assert-R1Session -RequireToken } | Should -Throw '*authentication token*'

			}

			It 'does not throw when a token is not required' {

				{ Assert-R1Session } | Should -Not -Throw

			}

			It 'stops the calling command before it sends its request' {

				{ Get-R1Cache } | Should -Throw
				Should -Invoke -CommandName Invoke-R1RestMethod -Times 0 -Exactly -Scope It

			}

		}

	}

}
