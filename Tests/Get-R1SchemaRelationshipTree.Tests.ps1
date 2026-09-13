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

			Mock Invoke-R1RestMethod -MockWith {
				[pscustomobject]@{ 'dn' = 'dv=root'; 'rdn' = 'dv=root'; 'type' = 'PRIMARY'; 'children' = @() }
			}

		}

		Context 'Root' {

			It 'sends request to expected endpoint' {

				$null = Get-R1SchemaRelationshipTree -schemaName 'default'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/schemas/default/relationship_tree')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1SchemaRelationshipTree -schemaName 'default'

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.RelationshipNode'

			}

		}

		Context 'Node' {

			It 'sends request to the named node' {

				$null = Get-R1SchemaRelationshipTree -schemaName 'default' -relationshipDn 'dv=orders'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/schemas/default/relationship_tree/dv%3Dorders')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
