# .ExternalHelp psRadiantOne-help.xml
function Set-R1SchemaTableField {
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
		[string]$tableName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$fields
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/tables/$($tableName | Get-EscapedString)/fields"

		if ($fields.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($fields)

		}

		if ($PSCmdlet.ShouldProcess($tableName, "Update Fields ($($fields.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
