# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamespaceView {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ViewFile')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'views'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ViewFile

		}

	}#process

	End { }#end

}
