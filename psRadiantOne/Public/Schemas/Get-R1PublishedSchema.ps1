# .ExternalHelp psRadiantOne-help.xml
function Get-R1PublishedSchema {
	[CmdletBinding()]
	[OutputType('System.String')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'schemas/published'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result

		}

	}#process

	End { }#end

}
