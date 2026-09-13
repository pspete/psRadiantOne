# .ExternalHelp psRadiantOne-help.xml
function Remove-R1SchemaTable {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$schemaName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$tableName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/tables/$($tableName | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($tableName, 'Delete Table View')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
