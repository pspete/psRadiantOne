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
					'name'                = 'acsclient'
					'description'         = 'A custom type'
					'backendCategory'     = 'custom'
					'userCreated'         = $true
					'readOnly'            = $false
					'pluginName'          = 'acs'
					'javaClassName'       = 'com.example.Acs'
					'isSchemaExtractable' = $true
					'meta'                = @([pscustomobject]@{ 'name' = 'url'; 'dataType' = 'STRING' })
				}
			}

		}

		Context 'All' {

			It 'sends request to the collection endpoint' {

				$null = Get-R1DataSourceType

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/data_source_types')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Name' {

			It 'sends request to the named endpoint' {

				$null = Get-R1DataSourceType -name 'acsclient'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/data_source_types/acsclient')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1DataSourceType -name 'acsclient'

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.DataSourceType'

			}

		}

	}

}
