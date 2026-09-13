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
				[pscustomobject]@{
					'id'          = 'rel1'
					'parent'      = [pscustomobject]@{ 'name' = 'default'; 'url' = '/schemas/default' }
					'source'      = 'APP.CUSTOMERS'
					'sourceAttrs' = @('CUSTOMERID')
					'dest'        = 'APP.ORDERS'
					'destAttrs'   = @('CUSTOMERID')
					'tags'        = @('primary')
				}
			}

		}

		Context 'All' {

			It 'sends request to the collection endpoint' {

				$null = Get-R1SchemaRelationship -schemaName 'default'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/schemas/default/relationships')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				$null = Get-R1SchemaRelationship -schemaName 'default'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Single' {

			It 'sends request to the named endpoint' {

				$null = Get-R1SchemaRelationship -schemaName 'default' -relationshipId 'rel1'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/schemas/default/relationships/rel1')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1SchemaRelationship -schemaName 'default' -relationshipId 'rel1'

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.Relationship'

			}

		}

	}

}
