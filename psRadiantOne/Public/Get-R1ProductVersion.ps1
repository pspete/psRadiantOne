# .ExternalHelp psRadiantOne-help.xml
function Get-R1ProductVersion {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ProductVersion')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'dashboard/product_version'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ProductVersion

		}

	}#process

	End { }#end

}
