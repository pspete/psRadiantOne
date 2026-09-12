# .ExternalHelp psRadiantOne-help.xml
function Remove-R1NamespaceView {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[Alias('viewName')]
		[string]$name
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "views/$($name | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($name, 'Delete View')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
