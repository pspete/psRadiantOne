# .ExternalHelp psRadiantOne-help.xml
function Set-R1TaskScheduler {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.TaskScheduler')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$defaultJvmParameters,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(1, 90)]
		[int]$deleteTasksOlderThanDays
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path 'task_scheduler'

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so a setting left unspecified keeps its current value.
		$Existing = Get-R1TaskScheduler

		#status, logLevel and taskLogLevel are reported by the API but are not part of the update
		$Template = [ordered]@{
			defaultJvmParameters    = $null
			deleteTasksOlderThanDays = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Task Scheduler Settings')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.TaskScheduler

			}

		}

	}#process

	End { }#end

}
