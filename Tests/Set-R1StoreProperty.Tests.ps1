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
					'isActive' = $true
					'storageLocation' = $null
					'isSchemaChecking' = $true
					'isEnsureSuperiorObjectClasses' = $false
					'isNormalizeAttributeNames' = $false
					'indexedAttributes' = @()
					'nonIndexedAttributes' = @('userpassword')
					'sortedAttributes' = @()
					'encryptedAttributes' = @()
					'isInterClusterRep' = $false
					'isEnsurePushModeEnabled' = $false
					'pushModeDataSources' = @()
					'replicationExcludedAttributes' = @()
					'isFullTextSearchEnabled' = $false
					'isOptimizeLinkAttributes' = $false
					'enableChangelog' = $false
					'asyncIndexing' = $false
				}
			}

			Set-R1StoreProperty -dn 'o=store' -indexedAttributes 'description' -Confirm:$false

		}

		Context 'Input' {

			It 'sends request to expected endpoint' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					($Method -eq 'PUT') -and ($URI -eq 'https://radiantone.company.com/directory-namespace-service/naming_contexts/o%3Dstore/store/properties')

				} -Times 1 -Exactly -Scope It

			}

			It 'retrieves the current properties before updating them' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter { $Method -eq 'GET' } -Times 1 -Exactly -Scope It

			}

			It 'sends a single indexed attribute as an array' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"indexedAttributes"\s*:\s*\[\s*"description"\s*\]'

				} -Times 1 -Exactly -Scope It

			}

			It 'preserves properties which were not specified' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.isSchemaChecking -eq $true) -and (@($Decoded.nonIndexedAttributes)[0] -eq 'userpassword')

				} -Times 1 -Exactly -Scope It

			}

			It 'sends the properties the control panel adds' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Decoded = $Body | ConvertFrom-Json
					($Decoded.type -eq 'RadiantOne Directory') -and ($Decoded.namingContext -eq 'o=store') -and ($Decoded.withoutCacheRefresh -eq $true)

				} -Times 1 -Exactly -Scope It

			}

			It 'sends empty collections as empty arrays' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"sortedAttributes"\s*:\s*\[\s*\]'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends an unset storage location as null' {

				Should -Invoke -CommandName Invoke-R1RestMethod -ParameterFilter {

					if ($Method -ne 'PUT') { return $false }
					$Body -match '"storageLocation"\s*:\s*null'

				} -Times 1 -Exactly -Scope It

			}

		}

	}

}
