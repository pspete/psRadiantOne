# .ExternalHelp psRadiantOne-help.xml
function Get-R1DataSourcePluginLibrary {
	[CmdletBinding()]
	[OutputType('psRadiantOne.LibraryReference')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$pluginName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "meta/plugins/$($pluginName | Get-EscapedString)/libraries"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LibraryReference

		}

	}#process

	End { }#end

}
