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

		}

		Context 'Ldap' {

			BeforeEach {

				New-R1DataSource -name 'opendj' -type 'Generic LDAP' -hostName 'ldap.example.com' -port 389 -bindDn 'cn=DirectoryManager' -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/data_sources') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the ldap category' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Decoded.category -eq 'ldap'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the host under its api property name' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.host -eq 'ldap.example.com') -and ($null -eq $Decoded.hostName)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so the password cannot be captured' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Database' {

			BeforeEach {

				New-R1DataSource -name 'advworks' -type 'Generic DB' -driverClassName 'org.postgresql.Driver' -url 'jdbc:postgresql://db/adv' -username 'appUser' -Confirm:$false

			}

			It 'sends the database category' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Decoded.category -eq 'database'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the database properties' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.url -eq 'jdbc:postgresql://db/adv') -and ($Decoded.username -eq 'appUser')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Custom' {

			BeforeEach {

				New-R1DataSource -name 'mycustom' -type 'Custom' -customProps @{ url = 'https://example.test' } -Confirm:$false

			}

			It 'sends the custom category' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Decoded.category -eq 'custom'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the custom properties' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Decoded.customProps.url -eq 'https://example.test'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Password' {

			It 'sends a supplied password' {

				$Secret = 'sup3rSecret' | ConvertTo-SecureString -AsPlainText -Force

				New-R1DataSource -name 'opendj' -type 'Generic LDAP' -hostName 'ldap.example.com' -port 389 -bindDn 'cn=DirectoryManager' -password $Secret -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Decoded.password -eq 'sup3rSecret'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
