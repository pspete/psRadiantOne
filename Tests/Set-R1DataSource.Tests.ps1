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

		}

		Context 'Input' {

			BeforeEach {

				Set-R1DataSource -name 'opendj' -description 'Updated' -useExistingCredentials -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -like 'https://radiantone.company.com/data-catalog-service/data_sources/opendj?*')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the data source before updating it' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Decoded.description -eq 'Updated'

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.host -eq 'ldap.example.com') -and ($Decoded.bindDn -eq 'cn=DirectoryManager') -and ($Decoded.category -eq 'ldap')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Password' {

			It 'sends a null password rather than the empty string the api returned' {

				Set-R1DataSource -name 'opendj' -description 'Updated' -useExistingCredentials -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Raw = [System.Text.Encoding]::UTF8.GetString($Body)
					($Raw -match '"password"\s*:\s*null') -and ($Raw -notmatch '"password"\s*:\s*""')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a supplied password' {

				$Secret = 'newSecret' | ConvertTo-SecureString -AsPlainText -Force

				Set-R1DataSource -name 'opendj' -password $Secret -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$Decoded.password -eq 'newSecret'

				} -Times 1 -Exactly -Scope It

			}

			It 'refuses a call which says nothing about the password' {

				{ Set-R1DataSource -name 'opendj' -description 'Updated' -Confirm:$false -ErrorAction Stop } |
					Should -Throw -ErrorId 'AmbiguousParameterSet,Set-R1DataSource'

			}

			It 'refuses a call which supplies a password and asks to keep the stored one' {

				$Secret = 'newSecret' | ConvertTo-SecureString -AsPlainText -Force

				{ Set-R1DataSource -name 'opendj' -password $Secret -useExistingCredentials -Confirm:$false -ErrorAction Stop } |
					Should -Throw -ErrorId 'AmbiguousParameterSet,Set-R1DataSource'

			}

			It 'does not ask the server to keep the stored password when one was supplied' {

				$Secret = 'newSecret' | ConvertTo-SecureString -AsPlainText -Force

				Set-R1DataSource -name 'opendj' -password $Secret -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -notmatch 'useExistingCredentials')

				} -Times 1 -Exactly -Scope It

			}

			It 'asks the server to keep the stored credentials when told to' {

				Set-R1DataSource -name 'opendj' -useExistingCredentials -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -cmatch 'useExistingCredentials=true')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so the password cannot be captured' {

				Set-R1DataSource -name 'opendj' -useExistingCredentials -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($Body -is [byte[]])

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Schemas' {

			It 'sends a single schema name as a collection' {

				Set-R1DataSource -name 'opendj' -addedSchemas 'default' -useExistingCredentials -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Raw = [System.Text.Encoding]::UTF8.GetString($Body)
					$Raw -match '"addedSchemas"\s*:\s*\[\s*"default"\s*\]'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends null rather than a collection holding nothing when the api returns no schemas' {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{
						'name'         = 'opendj'
						'category'     = 'ldap'
						'addedSchemas' = $null
					}
				}

				Set-R1DataSource -name 'opendj' -description 'Updated' -useExistingCredentials -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Raw = [System.Text.Encoding]::UTF8.GetString($Body)
					($Raw -match '"addedSchemas"\s*:\s*null') -and ($Raw -notmatch '\[\s*null\s*\]')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
