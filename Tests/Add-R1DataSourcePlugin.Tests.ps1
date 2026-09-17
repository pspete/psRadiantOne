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

			Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ 'id' = 'imp1' } }

			$UploadFile = Join-Path $TestDrive 'templates.zip'
			Set-Content -Path $UploadFile -Value 'content' -Encoding Ascii

			$response = Add-R1DataSourcePlugin -Path $UploadFile -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/meta/plugins') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a multipart form data content type' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$ContentType -match '^multipart/form-data; boundary=\S+$'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the file as the file form field' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					$Decoded -match 'filename="templates.zip"'

				} -Times 1 -Exactly -Scope It

			}

			#The id is what Complete-R1DataSourceTypeImport and Remove-R1DataSourceTypeImport act on
			It 'returns the staged import' {

				$Result = Add-R1DataSourcePlugin -Path $UploadFile -Confirm:$false

				$Result.id | Should -Be 'imp1'

			}

			It 'returns it as a template import' {

				$Result = Add-R1DataSourcePlugin -Path $UploadFile -Confirm:$false

				$Result.psobject.TypeNames | Should -Contain 'psRadiantOne.TemplateImport'

			}

		}

	}

}
