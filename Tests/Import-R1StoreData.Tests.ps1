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

			Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ 'taskId' = 'abc123' } }

			$UploadFile = Join-Path $TestDrive 'data.ldif'
			Set-Content -Path $UploadFile -Value 'dn: o=x' -Encoding Ascii

			$Response = Import-R1StoreData -dn 'o=store' -Path $UploadFile -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'POST') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dstore/store/initialize/upload')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends multipart form data' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$ContentType -like 'multipart/form-data; boundary=*'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the file in the file field' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					[System.Text.Encoding]::UTF8.GetString($Body) -match 'name="file"; filename="data.ldif"'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'returns the launched task' {

				$Response.PSObject.TypeNames[0] | Should -Be 'psRadiantOne.LaunchedTask'

			}

		}

	}

}
