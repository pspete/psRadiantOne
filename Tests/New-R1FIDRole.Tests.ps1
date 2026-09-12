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

			New-R1FIDRole -name engineering -tasksPermission VIEW -Confirm:$false
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/roles'

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends expected request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.name -eq 'engineering') -and ($Decoded.tasksPermission -eq 'VIEW')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends roleToClone as a query parameter' {

				New-R1FIDRole -name engineering-lead -roleToClone engineering -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/authentication-service/roles?roleToClone=engineering'

				} -Times 1 -Exactly -Scope It

			}

			It 'excludes roleToClone from the request body' {

				New-R1FIDRole -name engineering-lead -roleToClone engineering -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.name -eq 'engineering-lead') -and ($null -eq $Decoded.roleToClone)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends nested permission objects' {

				New-R1FIDRole -name catalog -dataCatalogPermissions @{ dataSourcesPermission = 'EDIT' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).dataCatalogPermissions.dataSourcesPermission -eq 'EDIT'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends settingsPermissions as an object' {

				New-R1FIDRole -name settings -settingsPermissions @{ clientProtocolsPermission = 'EDIT'; tokenValidatorPermission = 'VIEW' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.settingsPermissions.clientProtocolsPermission -eq 'EDIT') -and
					($Decoded.settingsPermissions.tokenValidatorPermission -eq 'VIEW')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends tuningPermissions as an object' {

				New-R1FIDRole -name tuning -tuningPermissions @{ logSettingsPermission = 'EDIT' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).tuningPermissions.logSettingsPermission -eq 'EDIT'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
