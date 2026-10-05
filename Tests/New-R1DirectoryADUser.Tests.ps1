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

			$Password = ConvertTo-SecureString 'SomePassword' -AsPlainText -Force

			$InputObj = @{
				cn                        = 'SomeName'
				parentDn                  = 'ou=zOU,o=companydirectory'
				sAMAccountName            = 'SomeName'
				givenName                 = 'SomeName'
				sn                        = 'SomeName'
				password                  = $Password
				changePasswordAtNextLogon = $true
				cannotChangePassword      = $true
				passwordNeverExpires      = $true
				accountDisabled           = $true
			}

			New-R1DirectoryADUser @InputObj -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the dn built from the cn and parent' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).dn -eq 'cn=SomeName,ou=zOU,o=companydirectory'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the user object classes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					($oc.values -join ',') -eq 'top,person,organizationalPerson,user'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the attributes the control panel sends' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Names = @($Decoded.attributes | ForEach-Object { $PSItem.name }) | Sort-Object
					($Names -join ',') -eq 'cn,givenName,objectClass,pwdLastSet,sAMAccountName,sn,unicodePwd,userAccountControl'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the password as unicodePwd' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					(@($Decoded.attributes) | Where-Object { $PSItem.name -eq 'unicodePwd' }).values[0] -eq 'SomePassword'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so the password cannot be captured' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			It 'combines every setting into the value the control panel sends' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$uac = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'userAccountControl' }
					$pls = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'pwdLastSet' }
					($uac.values[0] -eq '66114') -and ($pls.values[0] -eq '0')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a normal account when no setting is given' {

				New-R1DirectoryADUser -cn 'Plain' -parentDn 'o=x' -sAMAccountName 'x' -sn 'x' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$uac = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'userAccountControl' }
					$pls = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'pwdLastSet' }
					($Decoded.dn -eq 'cn=Plain,o=x') -and ($uac.values[0] -eq '512') -and ($null -eq $pls)

				} -Times 1 -Exactly -Scope It

			}

			It 'sets <Expected> for <Name>' -TestCases @(
				@{ Name = 'accountDisabled'; Expected = '514' }
				@{ Name = 'cannotChangePassword'; Expected = '576' }
				@{ Name = 'passwordNeverExpires'; Expected = '66048' }
			) {

				param($Name, $Expected)

				$Setting = @{ $Name = $true }
				New-R1DirectoryADUser -cn 'Flag' -parentDn 'o=x' -sAMAccountName 'x' -sn 'x' @Setting -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$uac = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'userAccountControl' }
					($Decoded.dn -eq 'cn=Flag,o=x') -and ($uac.values[0] -eq $Expected)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a userAccountControl value unchanged' {

				New-R1DirectoryADUser -cn 'Raw' -parentDn 'o=x' -sAMAccountName 'x' -sn 'x' -userAccountControl 66048 -changePasswordAtNextLogon $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$uac = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'userAccountControl' }
					$pls = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'pwdLastSet' }
					($Decoded.dn -eq 'cn=Raw,o=x') -and ($uac.values[0] -eq '66048') -and ($pls.values[0] -eq '0')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not take a setting with a userAccountControl value' {

				{ New-R1DirectoryADUser -cn 'A' -parentDn 'o=x' -sAMAccountName 'x' -sn 'x' -userAccountControl 512 -accountDisabled $true -Confirm:$false } | Should -Throw

			}

			It 'sends nothing with WhatIf' {

				New-R1DirectoryADUser -cn 'A' -parentDn 'o=x' -sAMAccountName 'x' -sn 'x' -WhatIf

				#The one call is the BeforeEach call
				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

		}

	}

}
