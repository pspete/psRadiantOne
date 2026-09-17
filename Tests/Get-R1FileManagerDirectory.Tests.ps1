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

			#The shape the API answers with: the entries, wrapped in the flag for the directory listed
			Mock Invoke-R1RestMethod -MockWith {
				[pscustomobject]@{
					'uploadAllowed' = $false
					'entries'       = @(
						[pscustomobject]@{ 'name' = 'certs'; 'id' = '/certs'; 'directory' = $true; 'editable' = $false }
						[pscustomobject]@{ 'name' = 'lib'; 'id' = '/lib'; 'directory' = $true; 'editable' = $false }
					)
				}
			}

		}

		Context 'Input' {

			It 'sends request to the root when no path is given' {

				$null = Get-R1FileManagerDirectory

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/file_manager/directories')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the path when given' {

				$null = Get-R1FileManagerDirectory -path '/conf'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -match 'path='

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = @(Get-R1FileManagerDirectory)[0]

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.Directory'

			}

		Context 'Output' {

			It 'returns the entries, not the object wrapping them' {

				$Result = @(Get-R1FileManagerDirectory)

				$Result.Count | Should -Be 2
				$Result[0].name | Should -Be 'certs'
				$Result[1].id | Should -Be '/lib'

			}

			It 'carries the upload flag of the directory listed onto each entry' {

				(Get-R1FileManagerDirectory)[0].uploadAllowed | Should -Be $false

			}

			It 'returns what it was given when the API does not wrap it' {

				Mock Invoke-R1RestMethod -MockWith {
					@([pscustomobject]@{ 'name' = 'certs' })
				}

				(Get-R1FileManagerDirectory).name | Should -Be 'certs'

			}

		}

		}

	}

}
