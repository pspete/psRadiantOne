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

		}

		Context 'Coordinates' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith {
					[pscustomobject]@{ 'groupId' = 'com.example'; 'artifactId' = 'acs'; 'version' = '1.0' }
				}

			}

			It 'sends request to expected endpoint' {

				$null = Get-R1Library -groupId 'com.example' -artifactId 'acs' -version '1.0'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/libraries/com.example/acs/1.0')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1Library -groupId 'com.example' -artifactId 'acs' -version '1.0'

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.Library'

			}

		}

		Context 'All' {

			BeforeEach {

				$Script:PageRequest = 0

				Mock Invoke-R1RestMethod -MockWith {

					$Script:PageRequest++

					if ($Script:PageRequest -eq 1) {

						[pscustomobject]@{ 'totalPages' = 2; 'result' = @([pscustomobject]@{ 'artifactId' = 'one' }) }

					} else {

						[pscustomobject]@{ 'totalPages' = 2; 'result' = @([pscustomobject]@{ 'artifactId' = 'two' }) }

					}

				}

			}

			It 'requests every page' {

				$null = Get-R1Library

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 2 -Exactly -Scope It

			}

			It 'returns the libraries from every page' {

				$response = Get-R1Library

				@($response).Count | Should -Be 2

			}

		}

	}

}
