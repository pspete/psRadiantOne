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

			$Expected = '{"linkParametersString":"CN=@[CN:VARCHAR]"}' | ConvertFrom-Json

			Mock Invoke-R1RestMethod -MockWith { $Expected }

			$response = Get-R1NamingContextLinkParameterString -dn 'dv=address book,o=vds' -linkParameterAttrName 'CN' -linkParameterAttrType 'VARCHAR'

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI.Split('?')[0] -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/dv%3Daddress%20book%2Co%3Dvds/link/parameters/parameter_string') -and
					(@($URI.Split('?')[1].Split('&') | Sort-Object) -join '&' -eq 'linkParameterAttrName=CN&linkParameterAttrType=VARCHAR')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'returns the linkParametersString value' {

				$response | Should -Be 'CN=@[CN:VARCHAR]'

			}

			It 'returns nothing when the API returns nothing' {

				Mock Invoke-R1RestMethod -MockWith { }

				Get-R1NamingContextLinkParameterString -dn 'dv=address book,o=vds' -linkParameterAttrName 'CN' -linkParameterAttrType 'VARCHAR' | Should -BeNullOrEmpty

			}

		}

	}

}
