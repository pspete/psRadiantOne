# .ExternalHelp psRadiantOne-help.xml
function Remove-R1FIDUser {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[a-zA-Z0-9_-]+$')]
		[string]$username
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path "users/$($username | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($username, 'Delete FID User')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
