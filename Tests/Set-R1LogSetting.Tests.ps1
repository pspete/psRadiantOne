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
				[pscustomobject]@{
					'logSettingsComponent'  = 'RadiantOne LDAP Access'
					'rolloverSize'          = '100MB'
					'archiveMaxFileCount'   = 10
					'integrityAssurance'    = $false
					'accessLogTextFormat'   = 'default'
					'textDestination'       = '/logs/access.log'
					'useIsoFormat'          = $true
					'timezone'              = 'UTC'
				}
			}

			Set-R1LogSetting -component 'RadiantOne LDAP Access' -rolloverSize '200MB' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/settings-service/log_settings/RadiantOne%20LDAP%20Access')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'retrieves the component settings before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).rolloverSize -eq '200MB'

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves the properties belonging to this variant' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$d = $Body | ConvertFrom-Json
					($d.textDestination -eq '/logs/access.log') -and ($d.timezone -eq 'UTC') -and ($d.useIsoFormat -eq $true)

				} -Times 1 -Exactly -Scope It

			}

			It 'keeps the discriminator the api uses to identify the variant' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).logSettingsComponent -eq 'RadiantOne LDAP Access'

				} -Times 1 -Exactly -Scope It

			}

			It 'introduces no property foreign to this variant' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					#enableDebugSSL belongs to RadiantOneServerLogSettings, not to the access variant
					$null -eq ($Body | ConvertFrom-Json).enableDebugSSL

				} -Times 1 -Exactly -Scope It

			}

			It 'expands a dictionary into advanced properties' {

				Set-R1LogSetting -component 'RadiantOne LDAP Access' -advancedProperties @{ maxHistory = '10' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$a = @(($Body | ConvertFrom-Json).advancedProperties)
					($a.Count -eq 1) -and ($a[0].key -eq 'maxHistory') -and ($a[0].value -eq '10')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends advanced properties already in the api shape unchanged' {

				Set-R1LogSetting -component 'RadiantOne LDAP Access' -advancedProperties @{ key = 'maxHistory'; value = '10' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$a = @(($Body | ConvertFrom-Json).advancedProperties)
					($a.Count -eq 1) -and ($a[0].key -eq 'maxHistory') -and ($a[0].value -eq '10')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the identifying parameter as a body property' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$null -eq ($Body | ConvertFrom-Json).component

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
