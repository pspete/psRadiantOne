# .ExternalHelp psRadiantOne-help.xml
function Get-R1DataSourcePluginClass {
	[CmdletBinding(DefaultParameterSetName = 'Installed')]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$pluginName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Import'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$importId
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Import') {

			$Path = "meta/import/$($importId | Get-EscapedString)/plugins/$($pluginName | Get-EscapedString)/classes"

		} else {

			$Path = "meta/plugins/$($pluginName | Get-EscapedString)/classes"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result

		}

	}#process

	End { }#end

}
