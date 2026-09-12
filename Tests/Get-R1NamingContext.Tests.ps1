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
					'label'      = 'o=vds'
					'nodeType'   = 'VIRTUAL_TREE'
					'dn'         = 'o=vds'
					'isRoot'     = $true
					'isActive'   = $true
					'hasChildren' = $false
				}
			}

		}

		Context 'Dn' {

			BeforeEach {

				$response = Get-R1NamingContext -dn 'o=vds'

			}

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dvds')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.NamingContextNode'

			}

		}

		Context 'All' {

			BeforeEach {

				$Script:PageRequest = 0

				Mock Invoke-R1RestMethod -MockWith {

					$Script:PageRequest++

					if ($Script:PageRequest -eq 1) {

						[pscustomobject]@{
							'nodes'      = @(
								[pscustomobject]@{ 'dn' = 'o=one'; 'nodeType' = 'STORE' },
								[pscustomobject]@{ 'dn' = 'o=two'; 'nodeType' = 'LDAP_PROXY' }
							)
							'pagination' = [pscustomobject]@{ 'limit' = 2; 'offset' = 0 }
						}

					} else {

						[pscustomobject]@{
							'nodes'      = @(
								[pscustomobject]@{ 'dn' = 'o=three'; 'nodeType' = 'VIRTUAL_TREE' }
							)
							'pagination' = [pscustomobject]@{ 'limit' = 2; 'offset' = 2 }
						}

					}

				}

			}

			It 'sends request to expected endpoint' {

				$null = Get-R1NamingContext

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -match '^https://radiantone\.company\.com/directory-namespace-service/naming_contexts\?'

				} -Times 2 -Exactly -Scope It

			}

			It 'requests every page until a partial page is returned' {

				$null = Get-R1NamingContext

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 2 -Exactly -Scope It

			}

			It 'returns the nodes from every page' {

				$response = Get-R1NamingContext

				@($response).Count | Should -Be 3

			}

			It 'requests the first page at offset zero' {

				$null = Get-R1NamingContext

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -match 'offset=0' } -Times 1 -Exactly -Scope It

			}

			It 'advances the offset by the number of nodes already received' {

				$null = Get-R1NamingContext

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -match 'offset=2' } -Times 1 -Exactly -Scope It

			}

			It 'carries the specified filters onto every page request' {

				$null = Get-R1NamingContext -searchFilter 'sales' -typeFilter 'ACTIVE' -limit 2

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -match 'searchFilter=sales') -and ($URI -match 'typeFilter=ACTIVE') -and ($URI -match 'limit=2')

				} -Times 2 -Exactly -Scope It

			}

			It 'sends a boolean using the lowercase json spelling' {

				$null = Get-R1NamingContext -activeOnly $true

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -cmatch 'activeOnly=true' } -Times 2 -Exactly -Scope It

			}

			It 'does not send a boolean using the powershell spelling' {

				$null = Get-R1NamingContext -activeOnly $true

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -cnotmatch 'activeOnly=True' } -Times 2 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1NamingContext

				@($response)[0].psobject.TypeNames[0] | Should -Be 'psRadiantOne.NamingContextNode'

			}

		}

	}

}
