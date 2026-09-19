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
				@([pscustomobject]@{ 'name' = 'vdAPPORDERS'; 'tableName' = 'APP.ORDERS'; 'relationshipDn' = 'APP.ORDERS'; 'attributes' = @(); 'id' = 'vdapporders_northwind_northwind_related' })
			}

			$Response = Get-R1RelatedObject -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -objectDn 'APP.ORDERS,APP.CUSTOMERS'

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/EMPLOYEES%2Co%3Dvds/object_builder/primary_objects/vdAPPEMPLOYEES/objects/related_objects_full')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the object dn' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).objectDn -eq 'APP.ORDERS,APP.CUSTOMERS'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'provides output' {

				$Response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected type' {

				$Response | Should -HaveCount 1
				$Response.PSObject.TypeNames[0] | Should -Be 'psRadiantOne.RelatedObject'

			}

		}

	}

}
