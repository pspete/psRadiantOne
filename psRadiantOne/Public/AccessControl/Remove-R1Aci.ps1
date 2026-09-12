# .ExternalHelp psRadiantOne-help.xml
function Remove-R1Aci {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[int64]$aciId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 5000)]
		[string]$baseDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "access_control/acis/$($aciId | Get-EscapedString)?baseDn=$($baseDn | Get-EscapedString)"
		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		if ($PSCmdlet.ShouldProcess("$aciId ($baseDn)", 'Delete ACI')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
