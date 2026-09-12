# .ExternalHelp psRadiantOne-help.xml
function Set-R1GlobalLimit {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$maxConnections,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$sizeLimit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$timeLimit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$lookThroughLimit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$writeTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$idleTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$numberProcessingQueues,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$maxWorkingThreads,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$maxPendingConnectionRequests
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'limits/global'

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so a setting left unspecified keeps its current value.
		$Existing = Get-R1GlobalLimit

		$Template = [ordered]@{
			maxConnections               = 1000
			sizeLimit                    = 0
			timeLimit                    = 0
			lookThroughLimit             = 0
			writeTimeout                 = 0
			idleTimeout                  = 900
			numberProcessingQueues       = 2
			maxWorkingThreads            = 16
			maxPendingConnectionRequests = 200
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Global Limits')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
