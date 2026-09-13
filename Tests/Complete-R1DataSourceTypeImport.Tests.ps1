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

			Complete-R1DataSourceTypeImport -id 'imp1' -templates 'acsclient' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/import/imp1') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the template names as a json array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					@($Decoded).Count -eq 1

				} -Times 1 -Exactly -Scope It

			}

			It 'sends several templates in one request' {

				Complete-R1DataSourceTypeImport -id 'imp1' -templates 'acsclient', 'other' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					@($Decoded).Count -eq 2

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
