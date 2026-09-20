# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContextMergedBackend {
	[CmdletBinding()]
	[OutputType('psRadiantOne.MergedBackend')]
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

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/ldap_proxy/backend/merged_backends"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.MergedBackend

		}

	}#process

	End { }#end

}
