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
					'name'            = 'default'
					'lastModified'    = '2026-01-30T09:30:00Z'
					'type'            = 'DATABASE'
					'dataSourceName'  = 'vds'
					'baseDn'          = 'o=base'
					'publishToServer' = $true
				}
			}

			Set-R1Schema -schemaName 'default' -publishToServer $false -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/data-catalog-service/schemas/default')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current properties before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).publishToServer -eq $false

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.dataSourceName -eq 'vds') -and ($Decoded.baseDn -eq 'o=base') -and ($Decoded.type -eq 'DATABASE')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the write only objects property' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$null -eq ($Body | ConvertFrom-Json).objects

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
