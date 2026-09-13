# .ExternalHelp psRadiantOne-help.xml
function Copy-R1DataSource {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$existingDataSource,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$newDataSourceName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ newDataSourceName = $newDataSourceName } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "data_sources/$($existingDataSource | Get-EscapedString)/copy`?$Query"

		if ($PSCmdlet.ShouldProcess($existingDataSource, "Clone Data Source to $newDataSourceName")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
