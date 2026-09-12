# .ExternalHelp psRadiantOne-help.xml
function Remove-R1PasswordPolicy {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$policyName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "password_policies/policy?policyName=$($policyName | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($policyName, 'Delete Password Policy')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
