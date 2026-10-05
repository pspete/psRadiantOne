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

			$InputObj = @{
				ou                       = 'zOU'
				parentDn                 = 'o=companydirectory'
				description              = 'Some OU'
				telephoneNumber          = '090989'
				facsimileTelephoneNumber = '78786789'
				postalAddress            = 'Some Address'
			}

			New-R1DirectoryOrganizationalUnit @InputObj -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the dn built from the ou and parent' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).dn -eq 'ou=zOU,o=companydirectory'

				} -Times 1 -Exactly -Scope It

			}

			It 'escapes the ou in the dn' {

				New-R1DirectoryOrganizationalUnit -ou 'Sales, East' -parentDn 'o=companydirectory' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).dn -eq 'ou=Sales\, East,o=companydirectory'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the organizationalUnit object classes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					($oc.values -join ',') -eq 'top,organizationalUnit'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the named attributes and no others' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Names = @($Decoded.attributes | ForEach-Object { $PSItem.name }) | Sort-Object
					($Names -join ',') -eq 'description,facsimileTelephoneNumber,objectClass,postalAddress,telephoneNumber'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send an ou attribute' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					-not (@($Decoded.attributes) | Where-Object { $PSItem.name -eq 'ou' })

				} -Times 1 -Exactly -Scope It

			}

			It 'sends nothing with WhatIf' {

				New-R1DirectoryOrganizationalUnit -ou 'zOU' -parentDn 'o=companydirectory' -WhatIf

				#The one call is the BeforeEach call
				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

		}

	}

}
