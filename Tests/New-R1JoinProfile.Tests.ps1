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
				[pscustomobject]@{ 'joinId' = 'northwind_vds'; 'joinType' = 'LEFT' }
			}

			$Source = [pscustomobject]@{ 'sourceType' = 'NAMESPACE_OBJECT'; 'name' = 'inetOrgPerson'; 'attributes' = @([pscustomobject]@{ 'name' = 'mail'; 'virtualName' = ''; 'tags' = @() }) }
			$Response = New-R1JoinProfile -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -name 'northwind_vds' -joinInputSource $Source -joinCondition '(&(employeeNumber=@[EMPLOYEEID:varchar])(objectclass=inetOrgPerson))' -returnAttributes 'mail' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/EMPLOYEES%2Co%3Dvds/object_builder/primary_objects/vdAPPEMPLOYEES/objects/join_profiles')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the join input source' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).joinInputSource.sourceType -eq 'NAMESPACE_OBJECT'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the join condition' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).joinCondition -eq '(&(employeeNumber=@[EMPLOYEEID:varchar])(objectclass=inetOrgPerson))'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends each returned attribute under its own name' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Attribute = @(($Body | ConvertFrom-Json).returnAttributes)[0]
					($Attribute.name -eq 'mail') -and ($Attribute.virtualName -eq 'mail')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send returnAllAttributes unless specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					-not ($Body -match 'returnAllAttributes')

				} -Times 1 -Exactly -Scope It

			}

			It 'returns the join profile' {

				$Response.PSObject.TypeNames[0] | Should -Be 'psRadiantOne.JoinProfile'

			}

		}

	}

}
