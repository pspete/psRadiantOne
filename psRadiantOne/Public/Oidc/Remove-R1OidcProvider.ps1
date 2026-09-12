# .ExternalHelp psRadiantOne-help.xml
function Remove-R1OidcProvider {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$configurationName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "oidc_providers/$($configurationName | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($configurationName, 'Delete OIDC Provider')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
