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

			$Attributes = @([pscustomobject]@{ 'name' = 'objectClass'; 'values' = @('top', 'organization') })

			New-R1DirectoryEntry -dn 'o=example' -attributes $Attributes -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the dn and attributes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.dn -eq 'o=example') -and (@($Decoded.attributes)[0].name -eq 'objectClass')

				} -Times 1 -Exactly -Scope It

			}

			It 'expands a dictionary into attributes with an array of values' {

				New-R1DirectoryEntry -dn 'o=example' -attributes @{ objectClass = 'top', 'organization'; o = 'example' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$o = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'o' }
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					(@($Decoded.attributes).Count -eq 2) -and ($o.values -is [array]) -and ($o.values[0] -eq 'example') -and (($oc.values -join ',') -eq 'top,organization')

				} -Times 1 -Exactly -Scope It

			}

			It 'takes the dn and attributes by position' {

				New-R1DirectoryEntry 'o=positional' @{ o = 'positional' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).dn -eq 'o=positional'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so an attribute value cannot be captured' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

		}

		Context 'ObjectClass' {

			BeforeEach {

				New-Variable -Name psRadiantOneObjectClassCache -Value @{ } -Scope Script -Force

				Mock Get-R1DirectoryObjectClass -MockWith {
					switch ($objectClass) {
						'inetOrgPerson' {
							[pscustomobject]@{
								objectClass   = 'inetOrgPerson'; superClass = 'person'; requiredAttrs = @()
								optionalAttrs = @(
									[pscustomobject]@{ name = 'mail'; alias = 'rfc822mailbox'; multiValued = $true }
									[pscustomobject]@{ name = 'displayName'; alias = $null; multiValued = $false }
									[pscustomobject]@{ name = 'l'; alias = 'locality localityname'; multiValued = $true }
								)
							}
						}
						'person' {
							[pscustomobject]@{
								objectClass   = 'person'; superClass = 'top'; optionalAttrs = @()
								requiredAttrs = @(
									[pscustomobject]@{ name = 'cn'; alias = $null; multiValued = $true }
									[pscustomobject]@{ name = 'sn'; alias = $null; multiValued = $true }
								)
							}
						}
						'top' {
							[pscustomobject]@{
								objectClass   = 'top'; superClass = $null; optionalAttrs = @()
								requiredAttrs = @([pscustomobject]@{ name = 'objectClass'; alias = $null; multiValued = $true })
							}
						}
					}
				}

			}

			It 'sends the object classes and the attributes given as parameters' {

				New-R1DirectoryEntry -dn 'cn=one,o=example' -objectClass inetOrgPerson -cn one -sn One -mail 'a@example.com', 'b@example.com' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Values = @{ }
					@($Decoded.attributes) | ForEach-Object { $Values[$PSItem.name] = @($PSItem.values) -join ',' }
					($Decoded.dn -eq 'cn=one,o=example') -and ($Values.Count -eq 4) -and
					($Values['objectClass'] -eq 'top,person,inetOrgPerson') -and ($Values['cn'] -eq 'one') -and
					($Values['sn'] -eq 'One') -and ($Values['mail'] -eq 'a@example.com,b@example.com')

				} -Times 1 -Exactly -Scope It

			}

			It 'takes an attribute by its alias' {

				New-R1DirectoryEntry -dn 'cn=one,o=example' -objectClass inetOrgPerson -cn one -sn One -rfc822mailbox 'a@example.com' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					(@($Decoded.attributes) | Where-Object { $PSItem.name -eq 'mail' }).values -eq 'a@example.com'

				} -Times 1 -Exactly -Scope It

			}

			It 'offers the required attributes first, then the rest by name' {

				$Command = Get-Command New-R1DirectoryEntry -ArgumentList '-objectClass', 'inetOrgPerson'
				($Command.Parameters.Values | Where-Object { $PSItem.IsDynamic }).Name -join ',' | Should -BeExactly 'cn,sn,displayName,l,mail'

			}

			It 'takes each of several aliases an attribute has' {

				$Command = Get-Command New-R1DirectoryEntry -ArgumentList '-objectClass', 'inetOrgPerson'
				$Command.Parameters['l'].Aliases -join ',' | Should -BeExactly 'locality,localityname'

			}

			It 'sends the rdn outside the attributes' {

				New-R1DirectoryEntry -dn 'cn=one,o=example' -rdn 'cn=one' -objectClass inetOrgPerson -cn one -sn One -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.rdn -eq 'cn=one') -and (@($Decoded.attributes).name -notcontains 'rdn')

				} -Times 1 -Exactly -Scope It

			}

			It 'offers <Name> as <Type>' -TestCases @(
				@{ Name = 'mail'; Type = [string[]] }
				@{ Name = 'displayName'; Type = [string] }
			) {

				$Command = Get-Command New-R1DirectoryEntry -ArgumentList '-objectClass', 'inetOrgPerson'
				$Command.Parameters[$Name].ParameterType | Should -Be $Type

			}

			It 'makes a required attribute mandatory' {

				$Command = Get-Command New-R1DirectoryEntry -ArgumentList '-objectClass', 'inetOrgPerson'
				$Command.Parameters['sn'].Attributes.Where({ $PSItem -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -BeTrue
				$Command.Parameters['mail'].Attributes.Where({ $PSItem -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -BeFalse

			}

			It 'offers no attribute parameters without a session' {

				$Script:psRadiantOneSession.Token = $null

				{ New-R1DirectoryEntry -dn 'cn=one,o=example' -objectClass inetOrgPerson -cn one -sn One -Confirm:$false } |
					Should -Throw -ErrorId 'NamedParameterNotFound,New-R1DirectoryEntry'
				Should -Invoke -CommandName Get-R1DirectoryObjectClass -Times 0 -Exactly -Scope It

			}

		}

	}

}
