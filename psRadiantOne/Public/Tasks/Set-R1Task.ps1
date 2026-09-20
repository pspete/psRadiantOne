# .ExternalHelp psRadiantOne-help.xml
function Set-R1Task {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$dedicatedJvm,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$jvmParameters,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidatePattern('^[0-9]{2}h [0-9]{2}m [0-9]{2}s$')]
		[string]$executionInterval,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$name
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path "tasks/$($id | Get-EscapedString)"

		#Retrieve the task and send it back with the supplied values applied over it, so a property
		#left unspecified keeps its current value.
		$Existing = Get-R1Task -id $id

		#non-recurrent tasks report executionInterval as the sentinel 'N_A', which the API rejects
		#if sent back on a PUT, so it cannot be used as a fallback value
		if ($Existing.executionInterval -eq 'N_A') {

			$Existing.executionInterval = $null

		}

		#status, recurrent, the execution times and the log list are reported by the API but are not
		#part of the update
		$Template = [ordered]@{
			id                = $id
			name              = $null
			dedicatedJvm      = $false
			jvmParameters     = $null
			executionInterval = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove id) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($id, 'Update Task')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
