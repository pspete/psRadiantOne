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

			New-R1NamingContextContainer -dn 'o=vds' -relationshipObjectDn 'APP.ORDERS,APP.CUSTOMERS' -isRelatedObjectsOnly $true -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dvds/add_container')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).relationshipObjectDn -eq 'APP.ORDERS,APP.CUSTOMERS'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the specified boolean' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).isRelatedObjectsOnly -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the dn in the request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$null -eq ($Body | ConvertFrom-Json).dn

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the flags which were not specified as false' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.isQuoteTableNames -eq $false) -and ($Decoded.isQuoteColumnNames -eq $false)

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$null -eq ($Body | ConvertFrom-Json).schema

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
