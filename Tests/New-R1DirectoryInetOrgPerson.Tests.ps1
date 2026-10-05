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
				cn                       = 'Full Name'
				sn                       = 'SN'
				parentDn                 = 'ou=zOU,o=companydirectory'
				uid                      = 'UserName'
				givenName                = 'GivenName'
				mail                     = 'someemail@domain.com'
				telephoneNumber          = '783498'
				facsimileTelephoneNumber = '49349'
				password                 = $Password
			}

			New-R1DirectoryInetOrgPerson @InputObj -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'names the entry by its cn by default' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).dn -eq 'cn=Full Name,ou=zOU,o=companydirectory'

				} -Times 1 -Exactly -Scope It

			}

			It 'names the entry by its uid when asked' {

				New-R1DirectoryInetOrgPerson -cn 'Some Name' -sn 'SN' -uid 'SomeName' -namingAttribute uid -parentDn 'ou=zOU,o=companydirectory' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$cn = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'cn' }
					($Decoded.dn -eq 'uid=SomeName,ou=zOU,o=companydirectory') -and ($cn.values[0] -eq 'Some Name')

				} -Times 1 -Exactly -Scope It

			}

			It 'escapes the naming value in the dn only' {

				New-R1DirectoryInetOrgPerson -cn 'Smith, John' -sn 'Smith' -parentDn 'ou=zOU,o=companydirectory' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$cn = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'cn' }
					($Decoded.dn -eq 'cn=Smith\, John,ou=zOU,o=companydirectory') -and ($cn.values[0] -eq 'Smith, John')

				} -Times 1 -Exactly -Scope It

			}

			It 'requires a uid to name the entry by its uid' {

				{ New-R1DirectoryInetOrgPerson -cn 'A' -sn 'A' -namingAttribute uid -parentDn 'o=x' -Confirm:$false } | Should -Throw

			}

			It 'sends the inetOrgPerson object classes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					($oc.values -join ',') -eq 'top,person,organizationalPerson,inetOrgPerson'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the attributes the control panel sends' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Names = @($Decoded.attributes | ForEach-Object { $PSItem.name }) | Sort-Object
					($Names -join ',') -eq 'cn,facsimileTelephoneNumber,givenName,mail,objectClass,sn,telephoneNumber,uid,userPassword'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends only the attributes given' {

				New-R1DirectoryInetOrgPerson -cn 'Min' -sn 'Min' -parentDn 'o=x' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Names = @($Decoded.attributes | ForEach-Object { $PSItem.name }) | Sort-Object
					($Decoded.dn -eq 'cn=Min,o=x') -and (($Names -join ',') -eq 'cn,objectClass,sn')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the password as userPassword' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					(@($Decoded.attributes) | Where-Object { $PSItem.name -eq 'userPassword' }).values[0] -eq 'SomePassword'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so the password cannot be captured' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			It 'sends nothing with WhatIf' {

				New-R1DirectoryInetOrgPerson -cn 'A' -sn 'A' -parentDn 'o=x' -WhatIf

				#The one call is the BeforeEach call
				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

		}

	}

}
