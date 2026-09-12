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
					'linkedAttributes'          = @([pscustomobject]@{ 'targetDn' = 'ou=x'; 'backlinkAttribute' = 'isMemberOf' })
					'dynamicGroupSettings'      = [pscustomobject]@{ 'memberAttribute' = 'MEMBER'; 'dynamicGroups' = @() }
					'unnestGroups'              = @('ou=groups,o=vds')
					'referentialIntegrityRules' = @()
					'attributeUniquenessRules'  = @()
				}
			}

			Set-R1NamingContextSpecialAttribute -dn 'o=vds' -unnestGroups 'ou=other,o=vds' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dvds/special_attributes')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current settings before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					@(($Body | ConvertFrom-Json).unnestGroups) -contains 'ou=other,o=vds'

				} -Times 1 -Exactly -Scope It

			}

			It 'replaces, rather than adds to, the specified collection' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					@(($Body | ConvertFrom-Json).unnestGroups).Count -eq 1

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves settings which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					(@($Decoded.linkedAttributes)[0].backlinkAttribute -eq 'isMemberOf') -and
					($Decoded.dynamicGroupSettings.memberAttribute -eq 'MEMBER')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the dn in the request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$null -eq ($Body | ConvertFrom-Json).dn

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
