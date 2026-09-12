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

			$UploadFile = Join-Path $TestDrive 'someLib.jar'
			Set-Content -Path $UploadFile -Value 'public class MyInterception { }' -Encoding Ascii

			Import-R1InterceptionScriptLibrary -Path $UploadFile -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-namespace-service/interception_scripts/libraries')

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

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Body -is [byte[]]

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the file as the file form field' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					$Decoded -match 'Content-Disposition: form-data; name="file"; filename="someLib.jar"'

				} -Times 1 -Exactly -Scope It

			}

			It 'declares the content type of the file' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					$Decoded -match 'Content-Type: application/java-archive'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the file contents' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					$Decoded -match 'public class MyInterception'

				} -Times 1 -Exactly -Scope It

			}

			It 'closes the multipart body with the boundary terminator' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Boundary = [regex]::Match($ContentType, 'boundary=(\S+)').Groups[1].Value
					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body)
					$Decoded -match "--$([regex]::Escape($Boundary))--"

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send an overwrite query parameter unless specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -notmatch 'isOverwrite' } -Times 1 -Exactly -Scope It

			}

			It 'sends the overwrite flag using the lowercase json spelling' {

				$File2 = Join-Path $TestDrive 'second-someLib.jar'
				Set-Content -Path $File2 -Value 'public class MyInterception { }' -Encoding Ascii

				Import-R1InterceptionScriptLibrary -Path $File2 -isOverwrite $true -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $URI -cmatch 'isOverwrite=true' } -Times 1 -Exactly -Scope It

			}

		}

	}

}
