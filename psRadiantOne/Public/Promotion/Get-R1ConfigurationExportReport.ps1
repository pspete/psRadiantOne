# .ExternalHelp psRadiantOne-help.xml
function Get-R1ConfigurationExportReport {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.ConfigurationExportReport')]
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

		$Path = 'configuration/export/auto/reports'

		if ($PSCmdlet.ParameterSetName -eq 'Timestamp') {

			$Path = "$Path/$($timestamp | ConvertTo-R1Timestamp | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ConfigurationExportReport

		}

	}#process

	End { }#end

}
