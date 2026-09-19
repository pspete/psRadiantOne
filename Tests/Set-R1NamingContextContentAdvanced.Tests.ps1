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
					'interceptOn' = @()
					'interceptionScriptFileName' = 'uid_.java'
					'javaClass' = 'com.rli.scripts.intercept.uid_'
					'objectClass' = $null
					'processJoinComputedAttrsNecessary' = $false
					'objectClassMapping' = 'top # person # organizationalPerson # inetorgperson'
					'dataSourceType' = 'DATABASE'
					'requestNecessaryAttrOnly' = $true
					'distinct' = $false
					'leftOuterJoin' = $false
					'searchCaseSensitivity' = 'IGNORE_CASE'
					'sqlWhereClause' = '1=1'
					'ldapFilter' = $null
					'maxRequestedAttributes' = 30
					'ldapFilterAttributes' = $null
				}
			}

			Set-R1NamingContextContentAdvanced -dn 'uid,o=vds' -distinct $true -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/uid%2Co%3Dvds/content/advanced')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current properties before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).distinct -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.requestNecessaryAttrOnly -eq $true) -and ($Decoded.searchCaseSensitivity -eq 'IGNORE_CASE') -and ($Decoded.sqlWhereClause -eq '1=1') -and ($Decoded.maxRequestedAttributes -eq 30)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends back the properties the api maintains' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.interceptionScriptFileName -eq 'uid_.java') -and ($Decoded.javaClass -eq 'com.rli.scripts.intercept.uid_') -and ($Decoded.dataSourceType -eq 'DATABASE')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends empty collections as empty arrays' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"interceptOn"\s*:\s*\[\s*\]'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Clearing the where clause' {

			BeforeEach {

				Set-R1NamingContextContentAdvanced -dn 'uid,o=vds' -sqlWhereClause '' -Confirm:$false

			}

			It 'sends an empty clause as null' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"sqlWhereClause"\s*:\s*null'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
