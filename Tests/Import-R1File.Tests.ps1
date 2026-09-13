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

			$UploadFile = Join-Path $TestDrive 'app.properties'
			Set-Content -Path $UploadFile -Value 'key=value' -Encoding Ascii

			Import-R1File -filePath '/conf/app.properties' -Path $UploadFile -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/file_manager/files/upload') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a multipart form data content type' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$ContentType -match '^multipart/form-data; boundary=\S+$'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the destination path as a text field' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					($Decoded -match 'name="filePath"') -and ($Decoded -match '/conf/app.properties')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the file as the file form field' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					$Decoded -match 'name="file"; filename="app.properties"'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
