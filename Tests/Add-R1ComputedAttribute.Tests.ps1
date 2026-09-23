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
								origin              = @('backend')
								precedentAttributes = @(
									[pscustomobject]@{ name = 'City'; origin = 'backend'; priority = 'NORMAL' }
								)
							}
						)
					}
				}
			}

			Mock Set-R1SecondaryObject -MockWith { }
			Mock Set-R1ComputedAttribute -MockWith { }

		}

		Context 'Input' {

			It 'saves the object model for the expected object' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					($dn -eq 'EMPLOYEES,o=vds') -and ($primaryObject -eq 'vdAPPEMPLOYEES')

				} -Times 1 -Exactly -Scope It

			}

			It 'appends the computedAttributes entry' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Entry = @($finalOutput.computedAttributes)[-1]
					(@($finalOutput.computedAttributes).Count -eq 2) -and ($Entry.name -eq 'City') -and
					($Entry.expression -eq 'randomUUID()') -and ($Entry.active -eq $true)

				} -Times 1 -Exactly -Scope It

			}

			It 'appends the computed origin last on an existing attribute' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'City' }
					(@($Attribute.origin) -join ',') -eq 'backend,computed'

				} -Times 1 -Exactly -Scope It

			}

			It 'appends the computed precedent last on an existing attribute' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'City' }
					(@($Attribute.precedentAttributes)[-1].origin -eq 'computed') -and
					(@($Attribute.precedentAttributes)[-1].priority -eq 'NORMAL')

				} -Times 1 -Exactly -Scope It

			}

			It 'creates a whole descriptor for an attribute which does not exist' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'zzNew' -expression 'randomUUID()' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'zzNew' }
					(@($Attribute.origin) -join ',' -eq 'computed') -and ($Attribute.isHidden -eq $false) -and
					($Attribute.canModifyHidden -eq $true) -and (@($Attribute.precedentAttributes).Count -eq 1)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the requested active state' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -active $false -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					@($finalOutput.computedAttributes)[-1].active -eq $false

				} -Times 1 -Exactly -Scope It

			}

			It 'saves a non-default priority in its own request' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -priority 'HIGHEST' -Confirm:$false

				Should -Invoke -CommandName Set-R1ComputedAttribute -ParameterFilter {

					($name -eq 'City') -and ($priority -eq 'HIGHEST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the create at the precedent default priority' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -priority 'HIGHEST' -Confirm:$false

				Should -Invoke -CommandName Set-R1SecondaryObject -ParameterFilter {

					$Attribute = $finalOutput.attributes | Where-Object { $_.virtualName -eq 'City' }
					@($Attribute.precedentAttributes)[-1].priority -eq 'NORMAL'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send a second request for the default priority' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -Confirm:$false

				Should -Invoke -CommandName Set-R1ComputedAttribute -Times 0 -Exactly -Scope It

			}

			It 'throws when the computed attribute already exists' {

				{ Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'cn' -expression 'randomUUID()' -Confirm:$false } |
					Should -Throw -ExpectedMessage "*'cn' already exists*"

			}

			It 'does not save when the computed attribute already exists' {

				{ Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'cn' -expression 'randomUUID()' -Confirm:$false } | Should -Throw

				Should -Invoke -CommandName Set-R1SecondaryObject -Times 0 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'returns no output' {

				Add-R1ComputedAttribute -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'City' -expression 'randomUUID()' -Confirm:$false |
					Should -BeNullOrEmpty

			}

		}

	}

}
