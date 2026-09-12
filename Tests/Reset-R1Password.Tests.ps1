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
				WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
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
				[pscustomobject]@{ 'Prop' = 'Value' }
			}

			Reset-R1Password -resetToken 'a1B2c3D4' -newPassword ('N3wP@ss' | ConvertTo-SecureString -AsPlainText -Force) -Confirm:$false
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/password_reset'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request body as UTF8 bytes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			It 'sends expected request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.resetToken -eq 'a1B2c3D4') -and ($Decoded.newPassword -eq 'N3wP@ss')

				} -Times 1 -Exactly -Scope It

			}

			It 'omits currentPassword when not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$null -eq ([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).currentPassword

				} -Times 1 -Exactly -Scope It

			}

			It 'sends currentPassword when specified' {

				Reset-R1Password -resetToken 'a1B2c3D4' -newPassword ('N3wP@ss' | ConvertTo-SecureString -AsPlainText -Force) -currentPassword ('0ldP@ss' | ConvertTo-SecureString -AsPlainText -Force) -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).currentPassword -eq '0ldP@ss'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
