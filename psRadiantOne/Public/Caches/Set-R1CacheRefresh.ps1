# .ExternalHelp psRadiantOne-help.xml
function Set-R1CacheRefresh {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('label')]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$refreshCronExpression,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$validationScriptPath,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$addValidationThreshold,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$deleteValidationThreshold
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "caches/$($dn | Get-EscapedString)/refresh"

		#Retrieve the current settings, so that a periodic refresh keeps the validation settings it
		#already has unless they are specified
		$Existing = Get-R1CacheRefresh -dn $dn

		$Template = [ordered]@{
			refreshCronExpression     = $null
			validationScriptPath      = ''
			addValidationThreshold    = 0
			deleteValidationThreshold = 0
		}

		$Current = if ($Existing.refreshType -eq 'PERIODIC') { $Existing.PeriodicRefreshSettings }

		$Merge = @{
			Template       = $Template
			BoundParameter = ($PSBoundParameters | Get-Parameter -ParametersToRemove dn)
		}

		if ($null -ne $Current) {

			$Merge['Fallback'] = $Current

		}

		$Settings = Merge-R1Parameter @Merge

		if ($null -eq $Settings['validationScriptPath']) {

			$Settings['validationScriptPath'] = ''

		}

		$Body = [ordered]@{
			refreshType             = 'PERIODIC'
			PeriodicRefreshSettings = $Settings
		} | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, "Refresh Cache Periodically on '$refreshCronExpression'")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
