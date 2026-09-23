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

			Mock Get-R1SecondaryObject -MockWith {
				[pscustomobject]@{
					finalOutput = [pscustomobject]@{
						computedAttributes = @(
							[pscustomobject]@{ active = $true; name = 'cn'; expression = 'givenName+" "+sn' }
							[pscustomobject]@{ active = $false; name = 'City'; expression = 'randomUUID()' }
						)
						attributes         = @(
							[pscustomobject]@{
								virtualName         = 'cn'
								origin              = @('computed')
								precedentAttributes = @(
									[pscustomobject]@{ name = 'cn'; origin = 'computed'; priority = 'NORMAL' }
								)
							}
							[pscustomobject]@{
								virtualName         = 'City'
								origin              = @('backend', 'computed')
								precedentAttributes = @(
									[pscustomobject]@{ name = 'City'; origin = 'backend'; priority = 'NORMAL' }
									[pscustomobject]@{ name = 'City'; origin = 'computed'; priority = 'HIGHEST' }
								)
							}
						)
					}
				}
			}

		}

		Context 'Input' {

			It 'reads the object model for the expected object' {

				$null = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES'

				Should -Invoke -CommandName Get-R1SecondaryObject -ParameterFilter {

					($dn -eq 'EMPLOYEES,o=vds') -and ($primaryObject -eq 'vdAPPEMPLOYEES')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'returns every computed attribute' {

				$Response = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES'
				$Response.Count | Should -Be 2

			}

			It 'returns the requested computed attribute only' {

				$Response = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City'
				$Response.name | Should -Be 'City'

			}

			It 'returns the expression' {

				$Response = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'cn'
				$Response.expression | Should -Be 'givenName+" "+sn'

			}

			It 'returns the priority from the computed precedent' {

				$Response = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City'
				$Response.priority | Should -Be 'HIGHEST'

			}

			It 'returns the active state' {

				$Response = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City'
				$Response.active | Should -Be $false

			}

			It 'returns nothing for an unknown name' {

				$Response = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'nosuch'
				$Response | Should -BeNullOrEmpty

			}

			It 'carries the object identity so output pipes to the mutating commands' {

				$Response = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'cn'
				$Response.dn | Should -Be 'EMPLOYEES,o=vds'
				$Response.primaryObject | Should -Be 'vdAPPEMPLOYEES'

			}

			It 'has expected typename' {

				$Response = Get-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'cn'
				$Response | Get-Member | Select-Object -ExpandProperty TypeName -Unique | Should -Be 'psRadiantOne.ComputedAttribute'

			}

		}

	}

}
