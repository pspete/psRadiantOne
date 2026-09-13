# .ExternalHelp psRadiantOne-help.xml
function Remove-R1DataSourceType {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "meta/data_source_types/$($name | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($name, 'Delete Data Source Type')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
