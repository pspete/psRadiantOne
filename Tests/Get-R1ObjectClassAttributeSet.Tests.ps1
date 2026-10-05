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
				BaseURI = 'https://radiantone.company.com'
				Token   = 'SomeToken'
			}
			New-Variable -Name psRadiantOneSession -Value $psRadiantOneSession -Scope Script -Force
			New-Variable -Name psRadiantOneObjectClassCache -Value @{ } -Scope Script -Force

			Mock Get-R1DirectoryObjectClass -MockWith {
				switch ($objectClass) {
					'inetOrgPerson' {
						[pscustomobject]@{
							objectClass   = 'inetOrgPerson'; superClass = 'organizationalPerson'; requiredAttrs = @()
							optionalAttrs = @([pscustomobject]@{ name = 'mail'; alias = 'rfc822mailbox'; multiValued = $true })
						}
					}
					'organizationalPerson' {
						[pscustomobject]@{
							objectClass   = 'organizationalPerson'; superClass = 'person'; requiredAttrs = @()
							optionalAttrs = @([pscustomobject]@{ name = 'title'; alias = $null; multiValued = $true })
						}
					}
					'person' {
						[pscustomobject]@{
							objectClass   = 'person'; superClass = 'top'
							requiredAttrs = @([pscustomobject]@{ name = 'cn'; alias = $null; multiValued = $true })
							optionalAttrs = @([pscustomobject]@{ name = 'description'; alias = $null; multiValued = $true })
						}
					}
					'top' {
						[pscustomobject]@{
							objectClass   = 'top'; superClass = $null
							requiredAttrs = @([pscustomobject]@{ name = 'objectClass'; alias = $null; multiValued = $true })
							optionalAttrs = @()
						}
					}
					'auxClass' {
						[pscustomobject]@{
							objectClass   = 'auxClass'; superClass = 'top'
							requiredAttrs = @([pscustomobject]@{ name = 'description'; alias = $null; multiValued = $true })
							optionalAttrs = @()
						}
					}
				}
			}

		}

		Context 'Object classes' {

			It 'follows an object class up through its superclasses' {

				(Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson).objectClass -join ',' |
					Should -BeExactly 'top,person,organizationalPerson,inetOrgPerson'

			}

			It 'adds an auxiliary class without repeating a shared superclass' {

				(Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson, auxClass).objectClass -join ',' |
					Should -BeExactly 'top,person,organizationalPerson,inetOrgPerson,auxClass'

			}

		}

		Context 'Attributes' {

			It 'combines the attributes of every class reached' {

				(Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson).attributes.name -join ',' |
					Should -BeExactly 'mail,title,cn,description,objectClass'

			}

			It 'marks the attributes a class requires' {

				$Set = Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson
				($Set.attributes | Where-Object { $PSItem.isRequired }).name -join ',' | Should -BeExactly 'cn,objectClass'

			}

			It 'keeps the alias and whether an attribute is multivalued' {

				$Mail = (Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson).attributes | Where-Object { $PSItem.name -eq 'mail' }
				$Mail.alias | Should -BeExactly 'rfc822mailbox'
				$Mail.multiValued | Should -BeTrue

			}

			It 'requires an attribute any class requires' {

				$Description = (Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson, auxClass).attributes |
					Where-Object { $PSItem.name -eq 'description' }
				$Description.isRequired | Should -BeTrue

			}

		}

		Context 'Cache' {

			It 'reads each object class from the schema once' {

				$null = Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson
				$null = Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson

				Should -Invoke -CommandName Get-R1DirectoryObjectClass -Times 4 -Exactly -Scope It

			}

			It 'reads the schema again for another BaseURI' {

				$null = Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson
				$Script:psRadiantOneSession.BaseURI = 'https://other.company.com'
				$null = Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson

				Should -Invoke -CommandName Get-R1DirectoryObjectClass -Times 8 -Exactly -Scope It

			}

		}

	}

}
