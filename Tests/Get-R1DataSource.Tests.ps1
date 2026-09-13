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

		Context 'Name' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'name'           = 'opendj'
						'category'       = 'ldap'
						'type'           = 'Generic LDAP'
						'active'         = $true
						'description'    = 'A directory'
						'defaultSchema'  = 'default'
						'addedSchemas'   = @('default')
						'host'           = 'ldap.example.com'
						'port'           = 389
						'ssl'            = $false
						'bindDn'         = 'cn=DirectoryManager'
						'password'       = ''
						'baseDn'         = 'o=example'
					}
				}

				$response = Get-R1DataSource -name 'opendj'

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/data_sources/opendj')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.DataSource'

			}

		}

		Context 'All' {

			BeforeEach {

				$Script:PageRequest = 0

				Mock Invoke-R1RestMethod -MockWith {

					$Script:PageRequest++

					if ($Script:PageRequest -eq 1) {

						[pscustomobject]@{
							'totalItems'  = 3
							'totalPages'  = 2
							'currentPage' = 1
							'result'      = @([pscustomobject]@{ 'name' = 'one' }, [pscustomobject]@{ 'name' = 'two' })
						}

					} else {

						[pscustomobject]@{
							'totalItems'  = 3
							'totalPages'  = 2
							'currentPage' = 2
							'result'      = @([pscustomobject]@{ 'name' = 'three' })
						}

					}

				}

			}

			It 'requests every page' {

				$null = Get-R1DataSource

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 2 -Exactly -Scope It

			}

			It 'returns the data sources from every page' {

				$response = Get-R1DataSource

				@($response).Count | Should -Be 3

			}

			It 'asks for the first page first' {

				$null = Get-R1DataSource

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -match 'pageNumber=1' } -Times 1 -Exactly -Scope It

			}

			It 'asks for the second page' {

				$null = Get-R1DataSource

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -match 'pageNumber=2' } -Times 1 -Exactly -Scope It

			}

			It 'sends a boolean using the lowercase json spelling' {

				$null = Get-R1DataSource -activeOnly $true

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -cmatch 'activeOnly=true' } -Times 2 -Exactly -Scope It

			}

			It 'sends the specified filters' {

				$null = Get-R1DataSource -filter 'ldap' -sortOrder 'DESC'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -match 'filter=ldap') -and ($URI -match 'sortOrder=DESC')

				} -Times 2 -Exactly -Scope It

			}

		}

	}

}
