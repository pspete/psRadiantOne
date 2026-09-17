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

			Set-R1DataSourceType -name 'acsclient' -description 'Updated' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/data_source_types/acsclient')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the template before updating it' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).description -eq 'Updated'

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves the properties of the backend category it found' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.backendCategory -eq 'custom') -and ($Decoded.javaClassName -eq 'com.example.Acs') -and ($Decoded.pluginName -eq 'acs')

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves the nested meta properties' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					@(($Body | ConvertFrom-Json).meta)[0].name -eq 'url'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send a collection holding nothing when the api returns no meta' {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'name'            = 'csv'
						'backendCategory' = 'database'
						'meta'            = $null
					}
				}

				Set-R1DataSourceType -name 'csv' -icon '/cone.svg' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($Body -match '"name"\s*:\s*"csv"') -and ($Body -notmatch '\[\s*null\s*\]')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
