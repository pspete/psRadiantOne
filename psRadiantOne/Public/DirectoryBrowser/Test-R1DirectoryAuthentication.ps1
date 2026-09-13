# .ExternalHelp psRadiantOne-help.xml
function Test-R1DirectoryAuthentication {
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[securestring]$password
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Browser -Path 'directory_browser/test_authentication'

		$Request = [ordered]@{
			dn       = $dn
			password = $password | ConvertTo-InsecureString
		}

		$Body = $Request | ConvertTo-R1SecretBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result.success

		}

	}#process

	End { }#end

}
