# .ExternalHelp psRadiantOne-help.xml
function Get-R1DirectorySearchInfo {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DirectoryBrowserSearchInfo')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Browser -Path 'directory_browser/search/info'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DirectoryBrowserSearchInfo

		}

	}#process

	End { }#end

}
