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

			New-R1TokenValidator -name 'SomeValidator' -jsonWebKeySetUri 'https://idp.example.com/jwks' -apiService SCIM -claimsExpressionList 'uid=$sub' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request' {

				Should -Invoke -CommandName Invoke-R1RestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/settings-service/external_token_validators')

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends expected request body' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$d = $Body | ConvertFrom-Json
					($d.name -eq 'SomeValidator') -and ($d.apiService -eq 'SCIM')

				} -Times 1 -Exactly -Scope It

			}

			It 'wraps the claims expressions in a claimsMapper object' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					@(($Body | ConvertFrom-Json).claimsMapper.claimsExpressionList)[0] -eq 'uid=$sub'

				} -Times 1 -Exactly -Scope It

			}

			It 'does not send claimsExpressionList at the top level' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$null -eq ($Body | ConvertFrom-Json).claimsExpressionList

				} -Times 1 -Exactly -Scope It

			}

			It 'accepts the adap api service value' {

				New-R1TokenValidator -name 'AdapValidator' -jsonWebKeySetUri 'https://idp.example.com/jwks' -apiService 'REST(adap)' -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Body | ConvertFrom-Json).apiService -eq 'REST(adap)'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
