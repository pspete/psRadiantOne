# .ExternalHelp psRadiantOne-help.xml
function Set-R1AccessRegulationLimit {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$restrictionsIntervalPerUser,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$anonymousAccessChecking,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$authenticatedAccessChecking,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$specialUsersAccessChecking,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$anonymousMaxConnections,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$anonymousMaxOperationsPerSec,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$authenticatedMaxConnections,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$authenticatedMaxOperationsPerSec,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$specialUsersMaxConnections,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$specialUsersMaxOperationsPerSec,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$specialUsersGroupDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'limits/access_regulation'

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so a setting left unspecified keeps its current value.
		$Existing = Get-R1AccessRegulationLimit

		$Template = [ordered]@{
			restrictionsIntervalPerUser      = 0
			anonymousAccessChecking          = $false
			authenticatedAccessChecking      = $false
			specialUsersAccessChecking       = $false
			anonymousMaxConnections          = 0
			anonymousMaxOperationsPerSec     = 0
			authenticatedMaxConnections      = 0
			authenticatedMaxOperationsPerSec = 0
			specialUsersMaxConnections       = 0
			specialUsersMaxOperationsPerSec  = 0
			specialUsersGroupDn              = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Access Regulation Limits')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
