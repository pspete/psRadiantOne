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
				WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
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

			Set-R1FIDUserRole -username john_smith -roles admin, dev -Confirm:$false
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/users/john_smith/roles'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends roles as a json array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Body -eq (@('admin', 'dev') | ConvertTo-Json)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends an empty json array when no roles specified' {

				Set-R1FIDUserRole -username john_smith -roles @() -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Body -eq '[]'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single role as a json array' {

				Set-R1FIDUserRole -username john_smith -roles admin -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					#Assign before counting: Windows PowerShell's ConvertFrom-Json emits an array
					#root as a single object, so @($x | ConvertFrom-Json).Count is 1 whatever the
					#array holds. Assignment collects it properly on both hosts.
					$Decoded = $Body | ConvertFrom-Json
					@($Decoded).Count -eq 1

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
