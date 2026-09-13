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

				Mock Invoke-R1RestMethod -MockWith { @('top', 'person', 'inetOrgPerson') }

				$response = Get-R1DirectoryObjectClass

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-schema-service/object_classes')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'returns the names as strings' {

				@($response).Count | Should -Be 3
				@($response)[0] | Should -BeOfType [string]

			}

		}

		Context 'ObjectClass' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'objectClass'   = 'inetOrgPerson'
						'superClass'    = 'organizationalPerson'
						'oid'           = '2.16.840.1.113730.3.2.2'
						'isUserDefined' = $false
						'isAuxiliary'   = $false
						'requiredAttrs' = @([pscustomobject]@{ 'name' = 'cn' })
						'optionalAttrs' = @([pscustomobject]@{ 'name' = 'mail' })
					}
				}

				$response = Get-R1DirectoryObjectClass -objectClass 'inetOrgPerson'

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-schema-service/object_classes/inetOrgPerson')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.ObjectClass'

			}

		}

	}

}
