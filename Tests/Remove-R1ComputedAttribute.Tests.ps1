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
							[pscustomobject]@{ active = $true; name = 'City'; expression = 'randomUUID()' }
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

			Mock Set-R1SecondaryObject -MockWith { }

		}

		Context 'Input' {

			It 'drops the computedAttributes entry' {

				Remove-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					(@($finalOutput.computedAttributes).Count -eq 1) -and
					(@($finalOutput.computedAttributes)[0].name -eq 'cn')

				} -Times 1 -Exactly -Scope It

			}

			It 'keeps the descriptor when another origin remains' {

				Remove-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'City' }
					((@($Attribute.origin) -join ',') -eq 'backend') -and
					(@($Attribute.precedentAttributes).Count -eq 1) -and
					(@($Attribute.precedentAttributes)[0].origin -eq 'backend')

				} -Times 1 -Exactly -Scope It

			}

			It 'deletes the descriptor when computed was the only origin' {

				Remove-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'cn' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					($null -eq ($finalOutput.attributes | Where-Object { $_.virtualName -eq 'cn' })) -and
					(@($finalOutput.attributes).Count -eq 1)

				} -Times 1 -Exactly -Scope It

			}

			It 'leaves the other attributes alone' {

				Remove-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'cn' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'City' }
					(@($Attribute.origin) -join ',') -eq 'backend,computed'

				} -Times 1 -Exactly -Scope It

			}

			It 'saves the object model for the expected object' {

				Remove-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					($dn -eq 'EMPLOYEES,o=vds') -and ($primaryObject -eq 'vdAPPEMPLOYEES')

				} -Times 1 -Exactly -Scope It

			}

			It 'throws when the computed attribute does not exist' {

				{ Remove-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'nosuch' -Confirm:$false } |
					Should -Throw -ExpectedMessage "*No computed attribute named 'nosuch'*"

			}

			It 'does not save when the computed attribute does not exist' {

				{ Remove-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'nosuch' -Confirm:$false } | Should -Throw

				Should -Invoke -CommandName Set-R1SecondaryObject -Times 0 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'returns no output' {

				Remove-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -Confirm:$false |
					Should -BeNullOrEmpty

			}

		}

	}

}
