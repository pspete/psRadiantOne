# .ExternalHelp psRadiantOne-help.xml
function Remove-R1JdbcDriver {
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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "jdbc_drivers/upload/$($name | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($name, 'Delete Uploaded Driver')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
