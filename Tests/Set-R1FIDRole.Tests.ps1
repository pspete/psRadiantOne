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
				[pscustomobject]@{
					'name'                          = 'engineering'
					'entryDn'                       = 'cn=engineering,ou=globalroles,cn=config'
					'defaultRole'                   = $false
					'directoryBrowserPermission'    = 'VIEW'
					'identityManagerPermission'     = 'NONE'
					'tasksPermission'               = 'NONE'
					'globalSyncPermission'          = 'NONE'
					'observabilityPermission'       = 'NONE'
					'dashboardPermission'           = 'VIEW'
					'fileManagerPermission'         = 'NONE'
					'revokeTokenPermission'         = $false
					'dataCatalogPermissions'        = [pscustomobject]@{ 'dataSourcesPermission' = 'EDIT' }
					'securityPermissions'           = [pscustomobject]@{ 'accessControlPermission' = 'VIEW' }
					'directoryNamespacePermissions' = [pscustomobject]@{ 'namespaceDesignPermission' = 'NONE' }
					'tuningPermissions'             = [pscustomobject]@{ 'logSettingsPermission' = 'VIEW' }
					'settingsPermissions'           = [pscustomobject]@{ 'clientProtocolsPermission' = 'EDIT' }
					'administrationPermissions'     = [pscustomobject]@{ 'rolesPermission' = 'NONE' }
					'exportImportPermissions'       = [pscustomobject]@{ 'exportEnabled' = $true }
					'classicControlPanelPermission' = [pscustomobject]@{ 'enabled' = $false }
				}
			}

			Set-R1FIDRole -name engineering -tasksPermission EDIT -Confirm:$false
		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/authentication-service/roles/engineering') -and ($Method -eq 'PUT')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends expected request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and (($Body | ConvertFrom-Json).tasksPermission -eq 'EDIT')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the existing role before updating it' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'preserves scalar permissions which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.directoryBrowserPermission -eq 'VIEW') -and ($Decoded.dashboardPermission -eq 'VIEW')

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves nested permission objects which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.dataCatalogPermissions.dataSourcesPermission -eq 'EDIT') -and
					($Decoded.settingsPermissions.clientProtocolsPermission -eq 'EDIT') -and
					($Decoded.tuningPermissions.logSettingsPermission -eq 'VIEW')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send defaultRole, which the api maintains' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$null -eq ($Body | ConvertFrom-Json).defaultRole

				} -Times 1 -Exactly -Scope It

			}

			It 'overrides only the specified permission' {

				Set-R1FIDRole -name engineering -settingsPermissions @{ tokenValidatorPermission = 'EDIT' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.settingsPermissions.tokenValidatorPermission -eq 'EDIT') -and
					($Decoded.directoryBrowserPermission -eq 'VIEW')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
