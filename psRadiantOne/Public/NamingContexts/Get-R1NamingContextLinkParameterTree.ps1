# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContextLinkParameterTree {
	[CmdletBinding()]
	[OutputType('psRadiantOne.LinkParameterTree')]
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

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/link/parameters/tree"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LinkParameterTree

		}

	}#process

	End { }#end

}
