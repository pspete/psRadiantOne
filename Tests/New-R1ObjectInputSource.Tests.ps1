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
				[pscustomobject]@{ 'sourceType' = 'NAMESPACE_OBJECT'; 'name' = 'inetOrgPerson' }
			}


		}

		Context 'Namespace' {

			BeforeEach {

				$Response = New-R1ObjectInputSource -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -targetBaseDn 'ou=people,o=example' -objectClass 'inetOrgPerson' -scope 'SUB' -sizeLimit 1 -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/EMPLOYEES%2Co%3Dvds/object_builder/primary_objects/vdAPPEMPLOYEES/objects/input_sources/add/namespace')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the namespace object' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.targetBaseDn -eq 'ou=people,o=example') -and ($Decoded.objectClass -eq 'inetOrgPerson') -and ($Decoded.scope -eq 'SUB')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the size limit as a string' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Body -match '"sizeLimit"\s*:\s*"1"'

				} -Times 1 -Exactly -Scope It

			}

			It 'returns the input source' {

				$Response.PSObject.TypeNames[0] | Should -Be 'psRadiantOne.InputSource'

			}

		}

		Context 'DataSourceSchema' {

			BeforeEach {

				New-R1ObjectInputSource -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -dataSource 'northwind' -schema 'northwind' -object 'APP.SHIPPERS' -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/EMPLOYEES%2Co%3Dvds/object_builder/primary_objects/vdAPPEMPLOYEES/objects/input_sources/add/data_source_schema')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the data source object' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.dataSource -eq 'northwind') -and ($Decoded.schema -eq 'northwind') -and ($Decoded.object -eq 'APP.SHIPPERS')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
