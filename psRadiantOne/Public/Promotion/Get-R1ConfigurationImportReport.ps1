# .ExternalHelp psRadiantOne-help.xml
function Get-R1ConfigurationImportReport {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.ConfigurationImportReport')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Timestamp'
		)]
		[ValidateNotNullOrEmpty()]
		[datetime]$timestamp
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'configuration/import/auto/reports'

		if ($PSCmdlet.ParameterSetName -eq 'Timestamp') {

			$Path = "$Path/$($timestamp | ConvertTo-R1Timestamp | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ConfigurationImportReport

		}

	}#process

	End { }#end

}
