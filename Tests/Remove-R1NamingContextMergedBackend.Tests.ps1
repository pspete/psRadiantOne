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

			Remove-R1NamingContextMergedBackend -dn 'o=vds' -radiantoneNamespaceDn 'ou=merged,o=vds' -dataSource 'ldapds' -remoteBaseDn 'ou=people,o=remote' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dvds/ldap_proxy/backend/merged_backends/delete')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the merged backend' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.radiantoneNamespaceDn -eq 'ou=merged,o=vds') -and ($Decoded.dataSource -eq 'ldapds') -and ($Decoded.remoteBaseDn -eq 'ou=people,o=remote')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the dn in the request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$null -eq ($Body | ConvertFrom-Json).dn

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Pipeline' {

			BeforeEach {

				[pscustomobject]@{ 'dataSource' = 'other'; 'remoteBaseDn' = 'ou=groups,o=remote'; 'radiantoneNamespaceDn' = 'ou=groups,o=vds' } | Remove-R1NamingContextMergedBackend -dn 'o=vds' -Confirm:$false

			}

			It 'accepts a merged backend from the pipeline' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).radiantoneNamespaceDn -eq 'ou=groups,o=vds'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
