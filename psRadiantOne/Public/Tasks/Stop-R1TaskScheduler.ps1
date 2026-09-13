# .ExternalHelp psRadiantOne-help.xml
function Stop-R1TaskScheduler {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path 'task_scheduler/stop'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Stop Task Scheduler')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
