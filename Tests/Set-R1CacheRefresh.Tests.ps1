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
				[pscustomobject]@{ 'refreshType' = 'PERIODIC'; 'PeriodicRefreshSettings' = [pscustomobject]@{ 'refreshCronExpression' = '0 0 * * * ?'; 'validationScriptPath' = 'check.js'; 'addValidationThreshold' = 10; 'deleteValidationThreshold' = 5 } }
			}

			Set-R1CacheRefresh -dn 'o=cache' -refreshCronExpression '0 0/10 * * * ?' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/caches/o%3Dcache/refresh')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current properties before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends a periodic refresh on the schedule given' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.refreshType -eq 'PERIODIC') -and ($Decoded.PeriodicRefreshSettings.refreshCronExpression -eq '0 0/10 * * * ?')

				} -Times 1 -Exactly -Scope It

			}

			It 'keeps the validation settings the cache has' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Settings = ($Body | ConvertFrom-Json).PeriodicRefreshSettings
					($Settings.validationScriptPath -eq 'check.js') -and ($Settings.addValidationThreshold -eq 10) -and ($Settings.deleteValidationThreshold -eq 5)

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'From another refresh type' {

			BeforeEach {

				Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ 'refreshType' = 'NONE'; 'PeriodicRefreshSettings' = $null } }
				Set-R1CacheRefresh -dn 'o=cache' -refreshCronExpression '0 0/10 * * * ?' -Confirm:$false

			}

			It 'sends the default validation settings' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Settings = ($Body | ConvertFrom-Json).PeriodicRefreshSettings
					($Settings.validationScriptPath -eq '') -and ($Settings.addValidationThreshold -eq 0) -and ($Settings.deleteValidationThreshold -eq 0)

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
