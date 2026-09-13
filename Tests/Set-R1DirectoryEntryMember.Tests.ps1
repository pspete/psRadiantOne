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

		Context 'Explicit' {

			It 'sends request to the explicit endpoint by default' {

				Set-R1DirectoryEntryMember -dn 'o=example' -members 'uid=one,o=example' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser/o%3Dexample/members/explicit') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the members as a json array' {

				Set-R1DirectoryEntryMember -dn 'o=example' -members 'uid=one,o=example', 'uid=two,o=example' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					@($Decoded).Count -eq 2

				} -Times 1 -Exactly -Scope It

			}

			It 'sends an empty collection as an empty json array' {

				Set-R1DirectoryEntryMember -dn 'o=example' -members @() -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq '[]' } -Times 1 -Exactly -Scope It

			}

		}

		Context 'Dynamic' {

			It 'sends request to the dynamic endpoint' {

				Set-R1DirectoryEntryMember -dn 'o=example' -members 'ldap:///o=example??sub?(objectClass=person)' -Dynamic -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser/o%3Dexample/members/dynamic')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
