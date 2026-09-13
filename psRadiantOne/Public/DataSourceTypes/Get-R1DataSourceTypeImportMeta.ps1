# .ExternalHelp psRadiantOne-help.xml
function Get-R1DataSourceTypeImportMeta {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.DataSourceType')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$importId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Name'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "meta/import/$($importId | Get-EscapedString)/meta"

		if ($PSCmdlet.ParameterSetName -eq 'Name') {

			$Path = "$Path/$($name | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DataSourceType

		}

	}#process

	End { }#end

}
