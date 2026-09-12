# .ExternalHelp psRadiantOne-help.xml
function Set-R1RestClientAccess {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$tokenTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$cookieTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(1, 10000)]
		[int]$maxThreads,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$alwaysAuthenticate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enabled
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'client_access/rest'

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so a setting left unspecified keeps its current value.
		$Existing = Get-R1RestClientAccess

		$Template = [ordered]@{
			tokenTimeout       = 360000
			cookieTimeout      = 600
			maxThreads         = 1000
			alwaysAuthenticate = $true
			enabled            = $true
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update REST Client Access Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
