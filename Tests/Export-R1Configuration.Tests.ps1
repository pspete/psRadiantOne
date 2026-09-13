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

		Context 'All' {

			It 'sends request to expected endpoint' {

				Export-R1Configuration -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/configuration/export/auto') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the all mode by default' {

				Export-R1Configuration -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).mode -eq 'ALL'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the force flag when specified' {

				Export-R1Configuration -force $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).force -eq $true

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Staged' {

			It 'sends the staged mode with the resources' {

				$Resources = [pscustomobject]@{ 'namingContexts' = @([pscustomobject]@{ 'name' = 'o=advworks' }) }

				Export-R1Configuration -stagedResources $Resources -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.mode -eq 'STAGED') -and (@($Decoded.stagedResources.namingContexts)[0].name -eq 'o=advworks')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
