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

		BeforeAll {

			function New-Response {
				param($Content, $ContentType = 'application/json')
				[pscustomobject]@{ Content = $Content; Headers = @{ 'Content-Type' = $ContentType } }
			}

		}

		It 'returns json content as an object' {

			$Result = New-Response -Content '{"name":"opendj","port":389}' | Get-R1Response

			$Result.name | Should -Be 'opendj'
			$Result.port | Should -Be 389

		}

		It 'decodes json which arrived as bytes' {

			$Bytes = [System.Text.Encoding]::UTF8.GetBytes('{"name":"opendj"}')

			(New-Response -Content $Bytes | Get-R1Response).name | Should -Be 'opendj'

		}

		#The api answers a successful create with a message, while still calling it json
		It 'returns a message which is not json as it stands' {

			$Message = 'Unable to create default schema. Default schema will need to be manually created.'

			New-Response -Content $Message | Get-R1Response | Should -Be $Message

		}

		It 'returns content of another type unaltered' {

			$Ldif = "dn: o=example`nobjectClass: top`n"

			New-Response -Content $Ldif -ContentType 'application/octet-stream' | Get-R1Response | Should -Be $Ldif

		}

		It 'returns nothing when there is no content' {

			New-Response -Content '' | Get-R1Response | Should -BeNullOrEmpty

		}

	}

}
