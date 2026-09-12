# .ExternalHelp psRadiantOne-help.xml
function Remove-R1InterceptionScriptLibrary {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$name
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "interception_scripts/libraries/$($name | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($name, 'Delete Interception Script Library')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
