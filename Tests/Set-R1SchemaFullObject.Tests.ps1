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
					'name'             = 'default'
					'lastModified'     = '2026-01-30T09:30:00Z'
					'type'             = 'DATABASE'
					'dataSourceName'   = 'vds'
					'baseDn'           = 'o=base'
					'publishToServer'  = $true
					'objects'          = $null
					'tablesWithFields' = @([pscustomobject]@{ 'name' = 'APP.CUSTOMERS'; 'fields' = @([pscustomobject]@{ 'name' = 'CID' }) })
					'relationships'    = @([pscustomobject]@{ 'id' = 'rel1'; 'source' = 'APP.CUSTOMERS' })
				}
			}

			Set-R1SchemaFullObject -schemaName 'default' -publishToServer $false -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/data-catalog-service/schemas/default/full_obj')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the complete schema before updating it' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).publishToServer -eq $false

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves the nested tables and relationships' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					(@($Decoded.tablesWithFields)[0].name -eq 'APP.CUSTOMERS') -and (@($Decoded.relationships)[0].id -eq 'rel1')

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves the nested fields of a table' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					@(@(($Body | ConvertFrom-Json).tablesWithFields)[0].fields)[0].name -eq 'CID'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends back the objects the api returned' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"objects"\s*:\s*null'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send a collection holding nothing when the api returns none' {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'name'             = 'default'
						'type'             = 'LDAP'
						'tablesWithFields' = $null
						'relationships'    = $null
					}
				}

				Set-R1SchemaFullObject -schemaName 'default' -baseDn 'o=base' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($Body -match '"type"\s*:\s*"LDAP"') -and ($Body -notmatch '\[\s*null\s*\]')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
