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

			$UploadFile = Join-Path $TestDrive 'datasources.json'
			Set-Content -Path $UploadFile -Value '{}' -Encoding Ascii

		}

		Context 'Json' {

			BeforeEach {

				Import-R1DataSource -Path $UploadFile -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/data_sources/import') -and ($Method -eq 'POST')

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
					$Decoded -match 'filename="datasources.json"'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Xml' {

			It 'sends request to the xml endpoint' {

				Import-R1DataSource -Path $UploadFile -Xml -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/data_sources/import_xml')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Options' {

			It 'sends no options when it was given none' {

				$null = Import-R1DataSource -Path $UploadFile -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -eq 'https://radiantone.company.com/data-catalog-service/data_sources/import'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the options it was given' {

				$null = Import-R1DataSource -Path $UploadFile -overrideExisting $true -performOpOnSchemas $false -crossEnvironment $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -match 'overrideExisting=true') -and ($URI -match 'performOpOnSchemas=false') -and ($URI -match 'crossEnvironment=true')

				} -Times 1 -Exactly -Scope It

			}

			#The api defines overrideExisting alone for the xml import
			It 'sends only overrideExisting to the xml import' {

				$null = Import-R1DataSource -Path $UploadFile -overrideExisting $true -performOpOnSchemas $false -Xml -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -match 'import_xml\?overrideExisting=true$')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
