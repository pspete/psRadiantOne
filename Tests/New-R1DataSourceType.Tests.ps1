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

		Context 'Ldap' {

			It 'sends the ldap backend category' {

				$null = New-R1DataSourceType -name 'myldap' -isLdap $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.backendCategory -eq 'ldap') -and ($Decoded.isLdap -eq $true)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				$null = New-R1DataSourceType -name 'myldap' -isLdap $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/data_source_types') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Database' {

			It 'sends the database backend category and properties' {

				$null = New-R1DataSourceType -name 'mydb' -driverClass 'org.postgresql.Driver' -urlPattern 'jdbc:postgresql://{host}/{db}' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.backendCategory -eq 'database') -and ($Decoded.driverClass -eq 'org.postgresql.Driver')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Custom' {

			It 'sends the custom backend category and properties' {

				$null = New-R1DataSourceType -name 'mycustom' -javaClassName 'com.example.Acs' -pluginName 'acs' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.backendCategory -eq 'custom') -and ($Decoded.javaClassName -eq 'com.example.Acs')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single meta property as an array' {

				$null = New-R1DataSourceType -name 'mycustom' -javaClassName 'com.example.Acs' -meta ([pscustomobject]@{ name = 'url' }) -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					@(($Body | ConvertFrom-Json).meta).Count -eq 1

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
