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
				[pscustomobject]@{ 'sourceType' = 'EXTENSIBLE_OBJECT'; 'name' = 'extensibleobject' }
			}

			$Response = New-R1ObjectExtension -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -attributes 'capNote' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/EMPLOYEES%2Co%3Dvds/object_builder/primary_objects/vdAPPEMPLOYEES/objects/extensions')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the default object class' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).objectClass -eq 'extensibleobject'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single attribute as a checked array item' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Body -match '"attributes"\s*:\s*\[\s*\{'
					@(($Body | ConvertFrom-Json).attributes)[0].isChecked -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'returns the input source' {

				$Response.PSObject.TypeNames[0] | Should -Be 'psRadiantOne.InputSource'

			}

		}

	}

}
