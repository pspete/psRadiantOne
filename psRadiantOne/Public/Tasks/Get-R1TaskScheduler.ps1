# .ExternalHelp psRadiantOne-help.xml
function Get-R1TaskScheduler {
	[CmdletBinding()]
	[OutputType('psRadiantOne.TaskScheduler')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path 'task_scheduler'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.TaskScheduler

		}

	}#process

	End { }#end

}
