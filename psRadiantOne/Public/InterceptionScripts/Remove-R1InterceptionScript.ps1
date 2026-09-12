# .ExternalHelp psRadiantOne-help.xml
function Remove-R1InterceptionScript {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$scriptName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "interception_scripts/$($scriptName | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($scriptName, 'Delete Interception Script')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
