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
				if ($URI -like '*/config') { return [pscustomobject]@{ 'type' = 'DB_TRIGGER'; 'properties' = @(
						[pscustomobject]@{ 'name' = 'pollingInterval'; 'type' = 'NUMBER'; 'value' = '5000'; 'editable' = $true }
						[pscustomobject]@{ 'name' = 'logTableUserPassword'; 'type' = 'PASSWORD'; 'value' = 'stored'; 'editable' = $true }
					) } }
				if ($URI -like '*/types') { return @([pscustomobject]@{ 'name' = 'DB_TIMESTAMP'; 'properties' = @([pscustomobject]@{ 'name' = 'timestampColumn'; 'type' = 'STRING'; 'value' = ''; 'editable' = $true }) }) }
			}

			Set-R1CacheRealTimeConnectorConfig -dn 'o=cache' -connectorId 'northwind_APP.EMPLOYEES' -properties @{ pollingInterval = 10000 } -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/caches/o%3Dcache/refresh/real_time_connectors/northwind_APP.EMPLOYEES/config')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current configuration before updating it' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { ($Method -eq 'GET') -and ($URI -like '*/config') } -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -is [byte[]]

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value as a string' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					(@($Decoded.properties | Where-Object name -EQ 'pollingInterval')[0].value -ceq '10000') -and ($Decoded.type -eq 'DB_TRIGGER')

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					@($Decoded.properties | Where-Object name -EQ 'logTableUserPassword')[0].value -eq 'stored'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Another type' {

			BeforeEach {

				Set-R1CacheRealTimeConnectorConfig -dn 'o=cache' -connectorId 'northwind_APP.EMPLOYEES' -type 'DB_TIMESTAMP' -properties @{ timestampColumn = 'MODIFIED' } -Confirm:$false

			}

			It 'starts from the properties the type offers' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.type -eq 'DB_TIMESTAMP') -and (@($Decoded.properties).Count -eq 1) -and (@($Decoded.properties)[0].value -eq 'MODIFIED')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Secure values' {

			BeforeEach {

				Set-R1CacheRealTimeConnectorConfig -dn 'o=cache' -connectorId 'northwind_APP.EMPLOYEES' -properties @{ logTableUserPassword = (ConvertTo-SecureString 'NewSecret' -AsPlainText -Force) } -Confirm:$false

			}

			It 'sends a secure value in plain text' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					@($Decoded.properties | Where-Object name -EQ 'logTableUserPassword')[0].value -eq 'NewSecret'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Unknown property' {

			It 'refuses a property the connector does not have' {

				{ Set-R1CacheRealTimeConnectorConfig -dn 'o=cache' -connectorId 'northwind_APP.EMPLOYEES' -properties @{ nosuch = 1 } -Confirm:$false } | Should -Throw '*no property named nosuch*'

			}

		}

	}

}
