# .ExternalHelp psRadiantOne-help.xml
function Search-R1Library {
	[CmdletBinding()]
	[OutputType('psRadiantOne.Library')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$filter
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'libraries/.search'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Library

		}

	}#process

	End { }#end

}
