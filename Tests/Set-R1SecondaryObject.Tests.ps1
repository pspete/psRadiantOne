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
					'inputSources'           = @([pscustomobject]@{ 'sourceType' = 'PRIMARY'; 'name' = 'APP.EMPLOYEES'; 'relatedObjects' = @() })
					'attributeMappings'      = @([pscustomobject]@{ 'name' = 'LASTNAME'; 'virtualName' = 'LASTNAME'; 'tags' = @(); 'source' = 'primary' })
					'joins'                  = @()
					'joinComputedAttributes' = @()
					'finalOutput'            = [pscustomobject]@{ 'attributes' = @([pscustomobject]@{ 'virtualName' = 'LASTNAME'; 'precedentAttributes' = @([pscustomobject]@{ 'name' = 'LASTNAME'; 'tags' = @() }) }); 'bindOrder' = [pscustomobject]@{ 'isDelegateAuth' = $false; 'sources' = @([pscustomobject]@{ 'name' = 'primary'; 'isEnabled' = $true }) }; 'computedAttributes' = @(); 'packagesAndClasses' = @() }
				}
			}

			Set-R1SecondaryObject -dn 'EMPLOYEES,o=vds' -primaryObject 'vdAPPEMPLOYEES' -attributeMappings @([pscustomobject]@{ 'name' = 'LASTNAME'; 'virtualName' = 'sn'; 'tags' = @(); 'source' = 'primary' }) -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/EMPLOYEES%2Co%3Dvds/object_builder/primary_objects/vdAPPEMPLOYEES/objects')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current object model before saving it' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified section' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					@(($Body | ConvertFrom-Json).attributeMappings)[0].virtualName -eq 'sn'

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves the nested sections which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					(@($Decoded.finalOutput.attributes)[0].precedentAttributes[0].name -eq 'LASTNAME') -and (@($Decoded.finalOutput.bindOrder.sources)[0].isEnabled -eq $true) -and (@($Decoded.inputSources)[0].name -eq 'APP.EMPLOYEES')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends single items as arrays' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body -match '"inputSources"\s*:\s*\[') -and ($Body -match '"attributeMappings"\s*:\s*\[')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends empty collections as empty arrays' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"joins"\s*:\s*\[\s*\]'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send the dn or primary object in the request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($null -eq $Decoded.dn) -and ($null -eq $Decoded.primaryObject)

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
