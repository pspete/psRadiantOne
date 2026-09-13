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

			It 'sends request to expected endpoint' {

				Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ 'meta' = $false; 'attributes' = @('cn', 'sn') } }

				$null = Get-R1DirectoryAttribute

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-schema-service/attributes')

				} -Times 1 -Exactly -Scope It

			}

			It 'returns the names when the api reports meta false' {

				Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ 'meta' = $false; 'attributes' = @('cn', 'sn', 'uid') } }

				$response = Get-R1DirectoryAttribute

				@($response).Count | Should -Be 3
				@($response)[0] | Should -BeOfType [string]

			}

			It 'returns the full attributes when the api reports meta true' {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'meta'       = $true
						'attributes' = @(
							[pscustomobject]@{ 'name' = 'cn'; 'syntax' = 'Directory String syntax' },
							[pscustomobject]@{ 'name' = 'sn'; 'syntax' = 'Directory String syntax' }
						)
					}
				}

				$response = Get-R1DirectoryAttribute -includeAllProperties $true

				@($response).Count | Should -Be 2
				@($response)[0].psobject.TypeNames[0] | Should -Be 'psRadiantOne.DirectorySchemaAttribute'

			}

			It 'sends the flags using the lowercase json spelling' {

				Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ 'meta' = $false; 'attributes' = @() } }

				$null = Get-R1DirectoryAttribute -includeAllProperties $true -includeSuperior $false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -cmatch 'includeAllProperties=true') -and ($URI -cmatch 'includeSuperior=false')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the object class filter' {

				Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ 'meta' = $false; 'attributes' = @() } }

				$null = Get-R1DirectoryAttribute -attributeObjectClasses 'person', 'inetOrgPerson'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -match 'attributeObjectClasses='

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Attribute' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'name'        = 'cn'
						'alias'       = @('commonName')
						'oid'         = '2.5.4.3'
						'syntax'      = 'Directory String syntax'
						'multiValued' = $true
					}
				}

				$response = Get-R1DirectoryAttribute -attribute 'cn'

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-schema-service/attributes/cn')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.DirectorySchemaAttribute'

			}

		}

	}

}
