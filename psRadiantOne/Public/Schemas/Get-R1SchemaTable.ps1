# .ExternalHelp psRadiantOne-help.xml
function Get-R1SchemaTable {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.Table')]
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
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'TableName'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$tableName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "schemas/$($schemaName | Get-EscapedString)/tables"

		if ($PSCmdlet.ParameterSetName -eq 'TableName') {

			$Path = "$Path/$($tableName | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Table

		}

	}#process

	End { }#end

}
