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
					'namingContext'     = 'o=vds'
					'directoryView'     = 'myview'
					'schema'            = 'myschema'
					'isActive'          = $true
					'dataSourceType'    = 'LDAP'
					'dataSourceName'    = 'opendj'
					'virtualAttributes' = @([pscustomobject]@{ 'name' = 'cn'; 'mappedName' = 'commonName' })
					'baseDn'            = 'o=base'
				}
			}

			Set-R1NamingContextVirtualTreeProperty -dn 'o=vds' -isActive $false -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dvds/virtual_tree/properties')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current properties before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).isActive -eq $false

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.directoryView -eq 'myview') -and ($Decoded.dataSourceName -eq 'opendj') -and ($Decoded.baseDn -eq 'o=base')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends back the properties the api maintains' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.namingContext -eq 'o=vds') -and ($Decoded.schema -eq 'myschema')

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves the nested virtual attributes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					@(($Body | ConvertFrom-Json).virtualAttributes)[0].mappedName -eq 'commonName'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
