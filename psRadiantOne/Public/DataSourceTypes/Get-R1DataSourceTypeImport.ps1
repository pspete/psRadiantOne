# .ExternalHelp psRadiantOne-help.xml
function Get-R1DataSourceTypeImport {
	[CmdletBinding()]
	[OutputType('psRadiantOne.TemplateImport')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('importId')]
		[string]$id
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "meta/import/$($id | Get-EscapedString)"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.TemplateImport

		}

	}#process

	End { }#end

}
