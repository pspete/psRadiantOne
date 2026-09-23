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

			Mock Invoke-R1RestMethod -MockWith { }

			$Attributes = @([pscustomobject]@{ 'name' = 'objectClass'; 'values' = @('top', 'organization') })

			New-R1DirectoryEntry -dn 'o=example' -attributes $Attributes -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the dn and attributes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.dn -eq 'o=example') -and (@($Decoded.attributes)[0].name -eq 'objectClass')

				} -Times 1 -Exactly -Scope It

			}

			It 'expands a dictionary into attributes with an array of values' {

				New-R1DirectoryEntry -dn 'o=example' -attributes @{ objectClass = 'top', 'organization'; o = 'example' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					$o = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'o' }
					$oc = @($Decoded.attributes) | Where-Object { $PSItem.name -eq 'objectClass' }
					(@($Decoded.attributes).Count -eq 2) -and ($o.values -is [array]) -and ($o.values[0] -eq 'example') -and (($oc.values -join ',') -eq 'top,organization')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so an attribute value cannot be captured' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

		}

	}

}
