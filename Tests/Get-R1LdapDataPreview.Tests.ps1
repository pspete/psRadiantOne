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
				@([pscustomobject]@{ 'dn' = 'o=example'; 'rdn' = 'o=example' })
			}

			$DataSource = [pscustomobject]@{ 'existingDataSource' = $true; 'dataSourceName' = 'opendj' }

		}

		Context 'Root' {

			It 'sends request to expected endpoint' {

				$null = Get-R1LdapDataPreview -dataSourceName 'advworks'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/data_preview/ldap') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so a password cannot be captured' {

				$null = Get-R1LdapDataPreview -dataSourceName 'advworks'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			#Two body shapes share this endpoint and the api picks between them on this property.
			It 'names the data source and the body shape it is sending' {

				$null = Get-R1LdapDataPreview -dataSourceName 'advworks'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					($Decoded.existingDataSource -eq $true) -and ($Decoded.dataSourceName -eq 'advworks')

				} -Times 1 -Exactly -Scope It

			}

			It 'takes the data source name from a data source on the pipeline' {

				$null = ([pscustomobject]@{ name = 'advworks' } | Get-R1LdapDataPreview)

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					([System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json).dataSourceName -eq 'advworks'

				} -Times 1 -Exactly -Scope It

			}

			It 'has expected typename' {

				$response = Get-R1LdapDataPreview -dataSourceName 'advworks'

				@($response)[0].psobject.TypeNames[0] | Should -Be 'psRadiantOne.PreviewBaseDnResponse'

			}

		}

		Context 'BaseDn' {

			It 'sends request to the base dn endpoint, escaped' {

				$null = Get-R1LdapDataPreview -dataSourceName 'advworks' -baseDn 'o=example'

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/data-catalog-service/data_preview/ldap/o%3Dexample')

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
