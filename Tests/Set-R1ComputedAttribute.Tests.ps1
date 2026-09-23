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
							[pscustomobject]@{ active = $true; name = 'City'; expression = 'randomUUID()' }
						)
						attributes         = @(
							[pscustomobject]@{
								virtualName         = 'City'
								origin              = @('backend', 'computed')
								precedentAttributes = @(
									[pscustomobject]@{ name = 'City'; origin = 'backend'; priority = 'NORMAL' }
									[pscustomobject]@{ name = 'City'; origin = 'computed'; priority = 'NORMAL' }
								)
							}
							[pscustomobject]@{
								virtualName         = 'sn'
								origin              = @('backend')
								precedentAttributes = @(
									[pscustomobject]@{ name = 'sn'; origin = 'backend'; priority = 'NORMAL' }
								)
							}
						)
					}
				}
			}

			Mock Set-R1SecondaryObject -MockWith { }

		}

		Context 'Input' {

			It 'saves the new expression' {

				Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'upper(City)' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Entry = $finalOutput.computedAttributes | Where-Object { $_.name -eq 'City' }
					$Entry.expression -eq 'upper(City)'

				} -Times 1 -Exactly -Scope It

			}

			It 'saves the new active state' {

				Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -active $false -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Entry = $finalOutput.computedAttributes | Where-Object { $_.name -eq 'City' }
					$Entry.active -eq $false

				} -Times 1 -Exactly -Scope It

			}

			It 'leaves the descriptor alone when only the expression changes' {

				Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'upper(City)' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'City' }
					$Precedent = $Attribute.precedentAttributes | Where-Object { $_.origin -eq 'computed' }
					((@($Attribute.origin) -join ',') -eq 'backend,computed') -and ($Precedent.priority -eq 'NORMAL')

				} -Times 1 -Exactly -Scope It

			}

			It 'saves the new priority' {

				Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -priority 'HIGHEST' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'City' }
					$Precedent = $Attribute.precedentAttributes | Where-Object { $_.origin -eq 'computed' }
					$Precedent.priority -eq 'HIGHEST'

				} -Times 1 -Exactly -Scope It

			}

			It 'leaves the backend precedent priority alone' {

				Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -priority 'HIGHEST' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'City' }
					$Precedent = $Attribute.precedentAttributes | Where-Object { $_.origin -eq 'backend' }
					$Precedent.priority -eq 'NORMAL'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a priority change in its own request' {

				Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'upper(City)' -priority 'HIGHEST' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -Times 2 -Exactly -Scope It

			}

			It 'reads the object model again before the priority request' {

				Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'upper(City)' -priority 'HIGHEST' -Confirm:$false

				Should -Invoke -CommandName Get-R1SecondaryObject -Times 2 -Exactly -Scope It

			}

			It 'throws when nothing is specified to change' {

				{ Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -Confirm:$false } |
					Should -Throw -ExpectedMessage '*at least one*'

			}

			It 'throws when the computed attribute does not exist' {

				{ Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'nosuch' -expression 'upper(City)' -Confirm:$false } |
					Should -Throw -ExpectedMessage "*No computed attribute named 'nosuch'*"

			}

			It 'does not save when the computed attribute does not exist' {

				{ Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'nosuch' -expression 'upper(City)' -Confirm:$false } | Should -Throw

				Should -Invoke -CommandName Set-R1SecondaryObject -Times 0 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'returns no output' {

				Set-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'upper(City)' -Confirm:$false |
					Should -BeNullOrEmpty

			}

		}

	}

}
