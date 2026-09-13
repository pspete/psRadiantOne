# .ExternalHelp psRadiantOne-help.xml
function Set-R1DataSourcePluginLibrary {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
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
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$libraries
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "meta/plugins/$($pluginName | Get-EscapedString)/libraries"

		if ($libraries.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($libraries)

		}

		if ($PSCmdlet.ShouldProcess($pluginName, "Set Plugin Libraries ($($libraries.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
