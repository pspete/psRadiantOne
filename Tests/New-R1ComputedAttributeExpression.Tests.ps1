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
				[pscustomobject]@{ 'expression' = 'upper(FIRSTNAME)' }
			}

			$Response = New-R1ComputedAttributeExpression -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -signature 'upper(attribute)' -values @{ attribute = 'FIRSTNAME' } -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/EMPLOYEES%2Co%3Dvds/object_builder/primary_objects/vdAPPEMPLOYEES/computed_attr_functions')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends each value by name' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.signature -eq 'upper(attribute)') -and (@($Decoded.values)[0].name -eq 'attribute') -and (@($Decoded.values)[0].value -eq 'FIRSTNAME')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single value as an array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Body -match '"values"\s*:\s*\['

				} -Times 1 -Exactly -Scope It

			}

			It 'returns the expression' {

				$Response | Should -Be 'upper(FIRSTNAME)'

			}

		}

	}

}
