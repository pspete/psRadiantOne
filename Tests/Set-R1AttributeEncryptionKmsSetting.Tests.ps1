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

			Mock Invoke-R1RestMethod -MockWith {
				[pscustomobject]@{
					'accessKeyIdExists'     = $true
					'accessKeySecretExists' = $true
					'cmkRegion'             = 'eu-west-2'
					'cmkAlias'              = 'alias/r1'
				}
			}

			Set-R1AttributeEncryptionKmsSetting -cmkAlias 'alias/new' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/settings-service/attribute_encryption/aws_kms')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'sends request body as UTF8 bytes' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { ($Method -eq 'PUT') -and ($Body -is [byte[]]) } -Times 1 -Exactly -Scope It

			}

			It 'preserves the region which was not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).cmkRegion -eq 'eu-west-2'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the credentials when specified' {

				Set-R1AttributeEncryptionKmsSetting -accessKeyId ('AKIA' | ConvertTo-SecureString -AsPlainText -Force) -accessKeySecret ('s3cret' | ConvertTo-SecureString -AsPlainText -Force) -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$d = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($d.accessKeyId -eq 'AKIA') -and ($d.accessKeySecret -eq 's3cret')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends useExistingCredentials as a query parameter when specified' {

				Set-R1AttributeEncryptionKmsSetting -useExistingCredentials -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/settings-service/attribute_encryption/aws_kms?useExistingCredentials=true')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
