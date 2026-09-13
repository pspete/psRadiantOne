# .ExternalHelp psRadiantOne-help.xml
function Remove-R1DataSourceSchemaLink {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$schemaName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ schemaName = $schemaName } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "data_sources/$($name | Get-EscapedString)/unlink_schema`?$Query"

		if ($PSCmdlet.ShouldProcess($name, "Unlink Schema $schemaName")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT

		}

	}#process

	End { }#end

}
