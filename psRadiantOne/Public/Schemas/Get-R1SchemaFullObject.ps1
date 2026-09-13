# .ExternalHelp psRadiantOne-help.xml
function Get-R1SchemaFullObject {
	[CmdletBinding()]
	[OutputType('psRadiantOne.SchemaComplete')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$schemaName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/full_obj"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.SchemaComplete

		}

	}#process

	End { }#end

}
