# .ExternalHelp psRadiantOne-help.xml
function Set-R1AccessControlSetting {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enableAci,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$allowAnonAccess,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$allowRootUserImpersonateOthers,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$allowAnonLegacyBehavior,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$bindReqPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enableNestedGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enableRootDseAci
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'access_control'

		#Retrieve the current settings and send them back with the supplied values applied over them,
		#so a setting left unspecified keeps its current value.
		$Existing = Get-R1AccessControlSetting

		$Template = [ordered]@{
			enableAci                      = $true
			allowAnonAccess                = $false
			allowRootUserImpersonateOthers = $true
			allowAnonLegacyBehavior        = $false
			bindReqPassword                = $true
			enableNestedGroups             = $false
			enableRootDseAci               = $false
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Access Control Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
