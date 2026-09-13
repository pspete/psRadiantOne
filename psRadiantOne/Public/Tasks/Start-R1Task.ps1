# .ExternalHelp psRadiantOne-help.xml
function Start-R1Task {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
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

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path "tasks/$($id | Get-EscapedString)/start"

		if ($PSCmdlet.ShouldProcess($id, 'Start Task')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
