# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContextDbProxyProperty {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DbProxyProperties')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/db_proxy/properties"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DbProxyProperties

		}

	}#process

	End { }#end

}
