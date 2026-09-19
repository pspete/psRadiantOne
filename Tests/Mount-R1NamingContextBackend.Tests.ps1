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

			Mock Invoke-R1RestMethod -MockWith { }

		}

		Context 'LdapProxy' {

			BeforeEach {

				Mount-R1NamingContextBackend -dn 'o=vds' -datasource 'vds' -remoteBaseDn 'o=companydirectory' -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dvds/mount_backend')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the ldap proxy backend type' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).backendType -eq 'LDAP_PROXY'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the data source and remote base dn' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.datasource -eq 'vds') -and ($Decoded.remoteBaseDn -eq 'o=companydirectory')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the dn in the request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$null -eq ($Body | ConvertFrom-Json).dn

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'DbProxy' {

			BeforeEach {

				Mount-R1NamingContextBackend -dn 'ou=db,o=vds' -datasource 'northwind' -schema 'northwind' -tableViews 'APP.EMPLOYEES' -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/ou%3Ddb%2Co%3Dvds/mount_backend')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the database proxy backend type' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).backendType -eq 'DB_PROXY'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single table as an array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Body -match '"tableViews"\s*:\s*\[\s*"APP.EMPLOYEES"\s*\]'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the quoting flags which were not specified as false' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.isQuoteTableNames -eq $false) -and ($Decoded.isQuoteColumnNames -eq $false)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the schema' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).schema -eq 'northwind'

				} -Times 1 -Exactly -Scope It

			}

		}


		Context 'Store' {

			BeforeEach {

				Mount-R1NamingContextBackend -dn 'o=store' -Store -Confirm:$false

			}

			It 'sends the store backend type, active' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.backendType -eq 'STORE') -and ($Decoded.isActive -eq $true) -and ($null -eq $Decoded.datasource)

				} -Times 1 -Exactly -Scope It

			}

		}
	}

}
