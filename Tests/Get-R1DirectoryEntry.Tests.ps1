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

		Context 'Root' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'nodes'  = @(
							[pscustomobject]@{
								'dn'         = 'o=example'
								'rdn'        = 'o=example'
								'attributes' = @([pscustomobject]@{ 'name' = 'objectClass'; 'values' = @('top') })
							}
						)
						'cursor' = $null
						'next'   = $null
					}
				}

			}

			It 'sends request to the root endpoint' {

				$null = Get-R1DirectoryEntry

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1DirectoryEntry

				@($response)[0].psobject.TypeNames[0] | Should -Be 'psRadiantOne.Entry'

			}

			It 'sends the requested attributes' {

				$null = Get-R1DirectoryEntry -attributes 'cn', 'sn'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -match 'attributes=' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Dn' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'nodes'  = @(
							[pscustomobject]@{
								'dn'         = 'o=example'
								'rdn'        = 'o=example'
								'attributes' = @([pscustomobject]@{ 'name' = 'objectClass'; 'values' = @('top') })
							}
						)
						'cursor' = $null
						'next'   = $null
					}
				}

			}

			It 'sends request to the escaped dn endpoint' {

				$null = Get-R1DirectoryEntry -dn 'o=example'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser/o%3Dexample')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the search filter and scope' {

				$null = Get-R1DirectoryEntry -dn 'o=example' -filter '(objectClass=person)' -scope 'SUB'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -match 'filter=') -and ($URI -match 'scope=SUB')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a boolean using the lowercase json spelling' {

				$null = Get-R1DirectoryEntry -dn 'o=example' -hierarchical $true

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -cmatch 'hierarchical=true' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Paging' {

			It 'follows the cursor until none is returned' {

				$Script:PageRequest = 0

				Mock Invoke-R1RestMethod -MockWith {

					$Script:PageRequest++

					if ($Script:PageRequest -eq 1) {

						[pscustomobject]@{ 'nodes' = @([pscustomobject]@{ 'dn' = 'one' }); 'cursor' = 'abc' }

					} else {

						[pscustomobject]@{ 'nodes' = @([pscustomobject]@{ 'dn' = 'two' }); 'cursor' = $null }

					}

				}

				$response = Get-R1DirectoryEntry -dn 'o=example' -pageSize 1

				@($response).Count | Should -Be 2

			}

			It 'sends the cursor on the second request' {

				$Script:PageRequest = 0

				Mock Invoke-R1RestMethod -MockWith {

					$Script:PageRequest++

					if ($Script:PageRequest -eq 1) {

						[pscustomobject]@{ 'nodes' = @([pscustomobject]@{ 'dn' = 'one' }); 'cursor' = 'abc' }

					} else {

						[pscustomobject]@{ 'nodes' = @(); 'cursor' = $null }

					}

				}

				$null = Get-R1DirectoryEntry -dn 'o=example' -pageSize 1

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -match 'cursor=abc' } -Times 1 -Exactly -Scope It

			}

		}

	}

}
