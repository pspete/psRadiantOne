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

		Context 'Escaping' {

			It 'joins a plain value to the attribute' {

				ConvertTo-R1Rdn -Attribute ou -Value 'people' | Should -BeExactly 'ou=people'

			}

			It 'escapes a comma' {

				ConvertTo-R1Rdn -Attribute cn -Value 'Smith, John' | Should -BeExactly 'cn=Smith\, John'

			}

			It 'escapes <Value>' -TestCases @(
				@{ Value = 'a\b'; Expected = 'cn=a\\b' }
				@{ Value = 'a+b'; Expected = 'cn=a\+b' }
				@{ Value = 'a"b'; Expected = 'cn=a\"b' }
				@{ Value = 'a<b>'; Expected = 'cn=a\<b\>' }
				@{ Value = 'a;b'; Expected = 'cn=a\;b' }
			) {

				param($Value, $Expected)

				ConvertTo-R1Rdn -Attribute cn -Value $Value | Should -BeExactly $Expected

			}

			It 'escapes a leading space or hash' {

				ConvertTo-R1Rdn -Attribute cn -Value ' a' | Should -BeExactly 'cn=\ a'
				ConvertTo-R1Rdn -Attribute cn -Value '#a' | Should -BeExactly 'cn=\#a'

			}

			It 'escapes a trailing space' {

				ConvertTo-R1Rdn -Attribute cn -Value 'a ' | Should -BeExactly 'cn=a\ '

			}

			It 'escapes a single space once' {

				ConvertTo-R1Rdn -Attribute cn -Value ' ' | Should -BeExactly 'cn=\ '

			}

			It 'leaves an equals sign and inner spaces alone' {

				ConvertTo-R1Rdn -Attribute cn -Value 'a = b' | Should -BeExactly 'cn=a = b'

			}

		}

	}

}
