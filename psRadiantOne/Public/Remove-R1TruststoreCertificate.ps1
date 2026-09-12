# .ExternalHelp psRadiantOne-help.xml
function Remove-R1TruststoreCertificate {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$alias
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "client_certificate_truststore/$($alias | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($alias, 'Delete Truststore Certificate')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
