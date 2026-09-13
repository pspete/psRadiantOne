# .ExternalHelp psRadiantOne-help.xml
function Stop-R1Task {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$id
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path "tasks/$($id | Get-EscapedString)/terminate"

		if ($PSCmdlet.ShouldProcess($id, 'Terminate Task')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
