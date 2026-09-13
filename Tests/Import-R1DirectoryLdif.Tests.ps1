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

			Mock Invoke-R1RestMethod -MockWith { [pscustomobject]@{ 'taskId' = 'task1' } }

			$UploadFile = Join-Path $TestDrive 'import.ldif'
			Set-Content -Path $UploadFile -Value 'dn: o=example' -Encoding Ascii

		}

		Context 'Local' {

			It 'sends request to the local endpoint' {

				$null = Import-R1DirectoryLdif -Path $UploadFile -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser/ldif/import_ldif/local') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a multipart form data content type' {

				$null = Import-R1DirectoryLdif -Path $UploadFile -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$ContentType -match '^multipart/form-data; boundary=\S+$'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the overwrite flag using the lowercase json spelling' {

				$null = Import-R1DirectoryLdif -Path $UploadFile -overwrite $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					($Decoded -match 'name="overwrite"') -and ($Decoded -cmatch 'true')

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Import-R1DirectoryLdif -Path $UploadFile -Confirm:$false

				$response.psobject.TypeNames[0] | Should -Be 'psRadiantOne.LaunchedTask'

			}

		}

		Context 'Server' {

			It 'sends request to the server endpoint' {

				$null = Import-R1DirectoryLdif -filename 'onserver.ldif' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser/ldif/import_ldif/server')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the file name as json' {

				$null = Import-R1DirectoryLdif -filename 'onserver.ldif' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($ContentType -eq 'application/json') -and (($Body | ConvertFrom-Json).filename -eq 'onserver.ldif')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
