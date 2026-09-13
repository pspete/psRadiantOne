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

			$Libraries = @([pscustomobject]@{ 'groupId' = 'com.example'; 'artifactId' = 'acs'; 'version' = '1.0' })

			Set-R1DataSourcePluginLibrary -pluginName 'acs' -libraries $Libraries -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/plugins/acs/libraries')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the libraries as a json array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					@($Decoded).Count -eq 1

				} -Times 1 -Exactly -Scope It

			}

			It 'sends an empty collection as an empty json array' {

				Set-R1DataSourcePluginLibrary -pluginName 'acs' -libraries @() -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -eq '[]' } -Times 1 -Exactly -Scope It

			}

		}

	}

}
