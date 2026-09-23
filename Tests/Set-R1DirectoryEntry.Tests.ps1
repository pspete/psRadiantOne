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

			$Modifications = @(
				[pscustomobject]@{ 'modifyType' = 'REPLACE'; 'attributes' = @([pscustomobject]@{ 'name' = 'description'; 'values' = @('new') }) }
			)

			Set-R1DirectoryEntry -dn 'o=example' -modifications $Modifications -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -eq 'https://radiantone.company.com/directory-browser-service/directory_browser/o%3Dexample/ldap_modify') -and ($Method -eq 'POST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the modifications as a json array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$Decoded = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json
					(@($Decoded).Count -eq 1) -and (@($Decoded)[0].modifyType -eq 'REPLACE')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the body as bytes so an attribute value cannot be captured' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Body -is [byte[]] } -Times 1 -Exactly -Scope It

			}

			It 'takes the dn and modifications by position' {

				Set-R1DirectoryEntry 'o=positional' $Modifications -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					$URI -like '*/o%3Dpositional/ldap_modify'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Attributes' {

			BeforeEach {

				$Decode = { [System.Text.Encoding]::UTF8.GetString($args[0]) | ConvertFrom-Json }

			}

			It 'sends a replace modification' {

				Set-R1DirectoryEntry -dn 'o=attr' -replace @{ region = 'EAST' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($URI -notlike '*/o%3Dattr/*') { return $false }
					$m = @(& $Decode $Body)
					($m.Count -eq 1) -and ($m[0].modifyType -eq 'REPLACE') -and ($m[0].attributes[0].name -eq 'region') -and
					($m[0].attributes[0].values -is [array]) -and ($m[0].attributes[0].values[0] -eq 'EAST')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends several attributes in one modification' {

				Set-R1DirectoryEntry -dn 'o=attr' -replace @{ region = 'EAST'; lastname = 'Jones' } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($URI -notlike '*/o%3Dattr/*') { return $false }
					$m = @(& $Decode $Body)
					($m.Count -eq 1) -and (@($m[0].attributes).Count -eq 2)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends delete, add and replace in that order in one request' {

				Set-R1DirectoryEntry -dn 'o=attr' -replace @{ l = 'London' } -add @{ mail = 'one@example.test' } -delete @{ phone = @() } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($URI -notlike '*/o%3Dattr/*') { return $false }
					(@(& $Decode $Body).modifyType -join ',') -eq 'DELETE,ADD,REPLACE'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a null delete value as an empty array' {

				Set-R1DirectoryEntry -dn 'o=attr' -delete @{ phone = $null } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($URI -notlike '*/o%3Dattr/*') { return $false }
					$Json = [System.Text.Encoding]::UTF8.GetString($Body)
					$Json -match '"values"\s*:\s*\[\s*\]'

				} -Times 1 -Exactly -Scope It

			}

			It 'omits a modification type given an empty hashtable' {

				Set-R1DirectoryEntry -dn 'o=attr' -replace @{ l = 'London' } -add @{ } -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($URI -notlike '*/o%3Dattr/*') { return $false }
					(@(& $Decode $Body).modifyType -join ',') -eq 'REPLACE'

				} -Times 1 -Exactly -Scope It

			}

			It 'binds the modifications from piped objects' {

				[pscustomobject]@{ dn = 'o=pipe1'; replace = @{ region = 'EAST' } },
				[pscustomobject]@{ dn = 'o=pipe2'; add = @{ mail = 'x@example.test' }; replace = @{ region = 'WEST' } } |
					Set-R1DirectoryEntry -Confirm:$false

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -like '*/o%3Dpipe1/*') -and ((@(& $Decode $Body).modifyType -join ',') -eq 'REPLACE')

				} -Times 1 -Exactly -Scope It

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($URI -like '*/o%3Dpipe2/*') -and ((@(& $Decode $Body).modifyType -join ',') -eq 'ADD,REPLACE')

				} -Times 1 -Exactly -Scope It

			}

			It 'throws when no modification is supplied' {

				{ Set-R1DirectoryEntry -dn 'o=attr' -Confirm:$false } | Should -Throw '*at least one attribute*'

			}

		}

	}

}
