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

		}

		Context 'Local' {

			BeforeEach {

				$UploadFile = Join-Path $TestDrive 'custom.ldif'
				Set-Content -Path $UploadFile -Value 'dn: cn=schema' -Encoding Ascii

				Import-R1DirectorySchemaFile -Path $UploadFile -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-schema-service/files/import')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends a multipart form data content type' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$ContentType -match '^multipart/form-data; boundary=\S+$'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			It 'sends the file as the file form field' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					$Decoded -match 'Content-Disposition: form-data; name="file"; filename="custom.ldif"'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send an override field unless specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					$Decoded -notmatch 'name="isOverride"'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the override flag using the lowercase json spelling' {

				$Second = Join-Path $TestDrive 'second.ldif'
				Set-Content -Path $Second -Value 'dn: cn=schema' -Encoding Ascii

				Import-R1DirectorySchemaFile -Path $Second -isOverride $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					($Decoded -match 'name="isOverride"') -and ($Decoded -cmatch 'true')

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Server' {

			BeforeEach {

				Import-R1DirectorySchemaFile -file 'ldapschema_14.ldif' -addBehavior 'ADD_OR_OVERRIDE' -Confirm:$false

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-schema-service/files/import')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a json content type' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$ContentType -eq 'application/json'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the server file name and behaviour' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = $Body | ConvertFrom-Json
					($Decoded.file -eq 'ldapschema_14.ldif') -and ($Decoded.addBehavior -eq 'ADD_OR_OVERRIDE')

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send a multipart body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -isnot [byte[]] } -Times 1 -Exactly -Scope It

			}

		}

	}

}
