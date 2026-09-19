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
				[pscustomobject]@{ 'Prop' = 'Value' }
			}

			#The roles are set on the user object, which is retrieved before it is sent back
			Mock Get-R1FIDUser -MockWith {
				[pscustomobject]@{
					username     = 'john_smith'
					firstName    = 'John'
					lastName     = 'Smith'
					entryDn      = 'uid=john_smith,ou=globalusers,cn=config'
					email        = $null
					active       = $true
					roles        = @()
					server       = $null
					organization = $null
					createdOn    = $null
					assumeRole   = $null
				}
			}

			Set-R1FIDUserRole -username john_smith -roles admin, dev -Confirm:$false
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'updates the user rather than the deprecated roles endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/users/john_smith'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends the roles on the user object' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Roles = ([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).roles
					(@($Roles).Count -eq 2) -and ($Roles -contains 'admin') -and ($Roles -contains 'dev')

				} -Times 1 -Exactly -Scope It

			}

			It 'keeps the properties it was not passed' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$User = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($User.firstName -eq 'John') -and ($User.lastName -eq 'Smith') -and ($User.active -eq $true)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends an empty array when no roles specified' {

				Set-R1FIDUserRole -username john_smith -roles @() -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					@(([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).roles).Count -eq 0

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single role as an array' {

				Set-R1FIDUserRole -username john_smith -roles admin -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					#Assign before counting: Windows PowerShell's ConvertFrom-Json emits an array
					#root as a single object, so @($x | ConvertFrom-Json).Count is 1 whatever the
					#array holds. Assignment collects it properly on both hosts.
					$Decoded = ([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).roles
					@($Decoded).Count -eq 1

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
