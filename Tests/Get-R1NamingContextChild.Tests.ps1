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
					'nodes'      = @(
						[pscustomobject]@{ 'dn' = 'ou=hr,o=vds'; 'nodeType' = 'DB_PROXY' }
					)
					'pagination' = [pscustomobject]@{ 'limit' = 50; 'offset' = 0 }
				}
			}

			$response = Get-R1NamingContextChild -dn 'o=vds'

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -match '^https://radiantone\.company\.com/directory-namespace-service/naming_contexts/o%3Dvds/children\?'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'does not send the dn as a query parameter' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -notmatch 'dn=' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified filters' {

				$null = Get-R1NamingContextChild -dn 'o=vds' -typeFilter 'STORES' -limit 10

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -match 'typeFilter=STORES') -and ($URI -match 'limit=10')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'has expected typename' {

				@($response)[0].psobject.TypeNames[0] | Should -Be 'psRadiantOne.NamingContextNode'

			}

		}

	}

}
