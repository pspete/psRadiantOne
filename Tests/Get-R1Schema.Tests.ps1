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

		}

		Context 'All' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					@(
						[pscustomobject]@{ 'name' = 'default'; 'type' = 'DATABASE' },
						[pscustomobject]@{ 'name' = 'other'; 'type' = 'LDAP' }
					)
				}

			}

			It 'sends request to expected endpoint' {

				$null = Get-R1Schema

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/schemas')

				} -Times 1 -Exactly -Scope It

			}

			It 'returns every schema' {

				$response = Get-R1Schema

				@($response).Count | Should -Be 2

			}

			It 'sends the linked schema flag using the lowercase json spelling' {

				$null = Get-R1Schema -includeLinkedSchemas $false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -cmatch 'includeLinkedSchemas=false' } -Times 1 -Exactly -Scope It

			}

			It 'omits the flag when it is not specified' {

				$null = Get-R1Schema

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -notmatch 'includeLinkedSchemas' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'SchemaName' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'name'            = 'default'
						'lastModified'    = '2026-01-30T09:30:00Z'
						'type'            = 'DATABASE'
						'dataSourceName'  = 'vds'
						'baseDn'          = 'o=base'
						'publishToServer' = $true
					}
				}

				$response = Get-R1Schema -schemaName 'default'

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/schemas/default')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.SchemaProperties'

			}

		}

	}

}
