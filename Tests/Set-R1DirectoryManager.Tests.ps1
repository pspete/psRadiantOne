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

			Set-R1DirectoryManager -userName 'cn=Directory Manager' -password ('P@ssword' | ConvertTo-SecureString -AsPlainText -Force) -Confirm:$false
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/directory_manager'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request body as UTF8 bytes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			It 'sends expected request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.userName -eq 'cn=Directory Manager') -and ($Decoded.password -eq 'P@ssword')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends oldPassword when specified' {

				Set-R1DirectoryManager -userName 'cn=Directory Manager' -password ('N3wP@ss' | ConvertTo-SecureString -AsPlainText -Force) -oldPassword ('0ldP@ss' | ConvertTo-SecureString -AsPlainText -Force) -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).oldPassword -eq '0ldP@ss'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single allowedIp as an array' {

				Set-R1DirectoryManager -userName 'cn=Directory Manager' -password ('P@ssword' | ConvertTo-SecureString -AsPlainText -Force) -allowedIps '10.0.0.1' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					(@($Decoded.allowedIps).Count -eq 1) -and (@($Decoded.allowedIps)[0] -eq '10.0.0.1')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
