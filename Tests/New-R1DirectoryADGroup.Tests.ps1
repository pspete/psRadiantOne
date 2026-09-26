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

			New-R1DirectoryADGroup -groupName 'ADGroup1' -parentDn 'ou=zOU,o=companydirectory' -description 'ADGroup1' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the dn built from the group name and parent' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).dn -eq 'cn=ADGroup1,ou=zOU,o=companydirectory'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the attributes the control panel sends' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Names = @($Decoded.attributes | ForEach-Object { $PSItem.name }) | Sort-Object
					($Names -join ',') -eq 'description,groupName,groupScope,groupType,objectClass'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the group object classes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					($oc.values -join ',') -eq 'top,group'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a global security group by default' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$gs = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'groupScope' }
					$gt = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'groupType' }
					($Decoded.dn -eq 'cn=ADGroup1,ou=zOU,o=companydirectory') -and ($gs.values[0] -eq 'globalGroup') -and ($gt.values[0] -eq '-2147483646')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends <Name> and <Type> for a <Category> <Scope> group' -TestCases @(
				@{ Scope = 'Global'; Category = 'Security'; Name = 'globalGroup'; Type = '-2147483646' }
				@{ Scope = 'DomainLocal'; Category = 'Security'; Name = 'domainLocalGroup'; Type = '-2147483644' }
				@{ Scope = 'Universal'; Category = 'Security'; Name = 'universalGroup'; Type = '-2147483640' }
				@{ Scope = 'Global'; Category = 'Distribution'; Name = 'globalGroup'; Type = '2' }
				@{ Scope = 'DomainLocal'; Category = 'Distribution'; Name = 'domainLocalGroup'; Type = '4' }
				@{ Scope = 'Universal'; Category = 'Distribution'; Name = 'universalGroup'; Type = '8' }
			) {

				param($Scope, $Category, $Name, $Type)

				New-R1DirectoryADGroup -groupName 'Scoped' -parentDn 'o=x' -groupScope $Scope -groupCategory $Category -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$gs = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'groupScope' }
					$gt = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'groupType' }
					($Decoded.dn -eq 'cn=Scoped,o=x') -and ($gs.values[0] -eq $Name) -and ($gt.values[0] -eq $Type)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends nothing with WhatIf' {

				New-R1DirectoryADGroup -groupName 'A' -parentDn 'o=x' -WhatIf

				#The one call is the BeforeEach call
				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

		}

	}

}
