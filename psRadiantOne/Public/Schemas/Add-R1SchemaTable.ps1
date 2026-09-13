# .ExternalHelp psRadiantOne-help.xml
function Add-R1SchemaTable {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('schema')]
		[string]$schemaName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string[]]$tableName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/tables/batch_append"

		$Body = ConvertTo-R1JsonBody -Body @($tableName)

		if ($PSCmdlet.ShouldProcess($schemaName, "Append Tables ($($tableName.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
