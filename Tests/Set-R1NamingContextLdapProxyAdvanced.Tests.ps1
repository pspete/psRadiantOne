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
					'javaClass' = 'com.rli.scripts.intercept.o_vds'
					'sourceLocation' = '/opt/radiantone/vds/vds_server/custom/src/com/rli/scripts/intercept/o_vds.java'
					'interceptOn' = @()
					'limitedAttributesRequested' = $true
					'joinOptimized' = $false
					'useClientSizeLimit' = $false
					'objectClassMapping' = @()
					'preProcessingFilter' = '(objectclass=*)'
					'postProcessingFilter' = $null
					'suffixBranchExclusion' = @()
					'suffixBranchInclusion' = @()
					'globalAttributesHandling' = @([pscustomobject]@{ 'actualName' = 'member'; 'virtualName' = 'member'; 'dnRemapping' = $true; 'alwaysRequested' = $false; 'hidden' = $false })
				}
			}

			Set-R1NamingContextLdapProxyAdvanced -dn 'o=vds' -useClientSizeLimit $true -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dvds/ldap_proxy/advanced')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current properties before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends the specified value' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).useClientSizeLimit -eq $true

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.limitedAttributesRequested -eq $true) -and ($Decoded.preProcessingFilter -eq '(objectclass=*)')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the script location as interceptionScriptFileName' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.interceptionScriptFileName -eq '/opt/radiantone/vds/vds_server/custom/src/com/rli/scripts/intercept/o_vds.java') -and ($null -eq $Decoded.sourceLocation)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends back the java class' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					($Body | ConvertFrom-Json).javaClass -eq 'com.rli.scripts.intercept.o_vds'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends a single global attribute as an array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"globalAttributesHandling"\s*:\s*\[\s*\{'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends empty collections as empty arrays' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"interceptOn"\s*:\s*\[\s*\]'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Clearing a filter' {

			BeforeEach {

				Set-R1NamingContextLdapProxyAdvanced -dn 'o=vds' -preProcessingFilter '' -Confirm:$false

			}

			It 'sends an empty filter as null' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"preProcessingFilter"\s*:\s*null'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
