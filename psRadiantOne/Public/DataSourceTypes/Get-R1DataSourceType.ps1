# .ExternalHelp psRadiantOne-help.xml
function Get-R1DataSourceType {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.DataSourceType')]
	param(
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

		$Path = 'meta/data_source_types'

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
