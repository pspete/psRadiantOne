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

		Context 'Dictionary input' {

			It 'outputs one item per dictionary entry' {

				$Result = @(ConvertTo-R1NameValueList -InputObject @{ cn = 'User One'; sn = 'One' })

				$Result.Count | Should -Be 2

			}

			It 'uses the default key and value names' {

				$Result = ConvertTo-R1NameValueList -InputObject @{ host = 'splunk.example.com' }

				$Result['name'] | Should -Be 'host'
				$Result['value'] | Should -Be 'splunk.example.com'

			}

			It 'uses the key and value names given' {

				$Result = ConvertTo-R1NameValueList -InputObject @{ maxHistory = '10' } -KeyName key -ValueName values

				$Result['key'] | Should -Be 'maxHistory'
				$Result['values'] | Should -Be '10'

			}

			It 'keeps the order of an ordered dictionary' {

				$Result = @(ConvertTo-R1NameValueList -InputObject ([ordered]@{ b = '1'; a = '2'; c = '3' }))

				$Result.ForEach({ $PSItem['name'] }) -join ',' | Should -Be 'b,a,c'

			}

			It 'sends a single value as an array when multivalued' {

				$Result = ConvertTo-R1NameValueList -InputObject @{ cn = 'User One' } -ValueName values -MultiValued

				($Result | ConvertTo-Json -Compress) | Should -Be '{"name":"cn","values":["User One"]}'

			}

			It 'sends several values as an array when multivalued' {

				$Result = ConvertTo-R1NameValueList -InputObject @{ objectClass = 'top', 'person' } -ValueName values -MultiValued

				($Result | ConvertTo-Json -Compress) | Should -Be '{"name":"objectClass","values":["top","person"]}'

			}

			It 'sends a single value as a scalar when not multivalued' {

				$Result = ConvertTo-R1NameValueList -InputObject @{ host = 'splunk.example.com' }

				($Result | ConvertTo-Json -Compress) | Should -Be '{"name":"host","value":"splunk.example.com"}'

			}

			It 'expands an entry named after the key property' {

				$Result = @(ConvertTo-R1NameValueList -InputObject @{ name = 'Some Name'; cn = 'User One' } -ValueName values -MultiValued)

				$Result.Count | Should -Be 2
				($Result | Where-Object { $PSItem['name'] -eq 'name' })['values'] | Should -Be 'Some Name'

			}

			It 'outputs nothing for an empty dictionary' {

				@(ConvertTo-R1NameValueList -InputObject @{ }).Count | Should -Be 0

			}

		}

		Context 'Item input' {

			It 'outputs a dictionary holding the key and value properties unchanged' {

				$Item = @{ name = 'host'; value = 'splunk.example.com'; label = 'Host' }

				$Result = ConvertTo-R1NameValueList -InputObject $Item

				[object]::ReferenceEquals($Result, $Item) | Should -BeTrue

			}

			It 'outputs an object unchanged' {

				$Item = [pscustomobject]@{ name = 'cn'; values = @('User One') }

				$Result = ConvertTo-R1NameValueList -InputObject $Item -ValueName values -MultiValued

				[object]::ReferenceEquals($Result, $Item) | Should -BeTrue

			}

			It 'accepts items and dictionaries together' {

				$Result = @(ConvertTo-R1NameValueList -InputObject @(
						@{ name = 'objectClass'; values = @('top') },
						@{ cn = 'User One' }
					) -ValueName values -MultiValued)

				$Result.ForEach({ $PSItem['name'] }) -join ',' | Should -Be 'objectClass,cn'

			}

			It 'skips null input' {

				@(ConvertTo-R1NameValueList -InputObject $null).Count | Should -Be 0

			}

		}

	}

}
