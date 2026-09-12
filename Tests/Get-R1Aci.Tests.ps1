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
					'aciString'               = 'SomeAci'
					'parsable'                = $true
					'aciId'                   = 12345
					'name'                    = 'SomeName'
					'targetDn'                = 'cn=config'
					'targetScope'             = 'SUBTREE'
					'targetFilter'            = '(objectclass=*)'
					'includeTargetAttributes' = $false
					'targetAttributes'        = @()
					'permsType'               = 'ALLOW'
					'selectedOperations'      = @('READ', 'SEARCH')
					'loaOperator'             = '<='
					'loaLevel'                = $null
					'daysOfWeek'              = @()
					'timeRanges'              = @()
					'applyUserDns'            = @()
					'applyGroupDns'           = @('cn=grp,cn=config')
					'applyIps'                = @()
				}
			}

			$response = Get-R1Aci

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/access_control/acis')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with no body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It 'sends baseDn as a query parameter when specified' {

				Get-R1Aci -baseDn 'cn=config'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/settings-service/access_control/acis?baseDn=cn%3Dconfig'

				} -Times 1 -Exactly -Scope It

			}

			It 'requests a single aci with its required baseDn' {

				Get-R1Aci -aciId 12345 -baseDn 'cn=config'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/settings-service/access_control/acis/12345?baseDn=cn%3Dconfig'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has expected typename' {

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.Aci'

			}

		}

	}

}
