# .ExternalHelp psRadiantOne-help.xml
function Set-R1GlobalAttributeSetting {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$hideOpAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$excludedHiddenOpAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$logsExcludedAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$binaryAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$excludedAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$multiValuedAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$keywordSearchAttrs
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'global_attributes/settings'

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so a setting left unspecified keeps its current value.
		$Existing = Get-R1GlobalAttributeSetting

		$Template = [ordered]@{
			hideOpAttrs           = $false
			excludedHiddenOpAttrs = @()
			logsExcludedAttrs     = @()
			binaryAttrs           = @()
			excludedAttrs         = @()
			multiValuedAttrs      = @()
			keywordSearchAttrs    = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		foreach ($Collection in 'excludedHiddenOpAttrs', 'logsExcludedAttrs', 'binaryAttrs', 'excludedAttrs', 'multiValuedAttrs', 'keywordSearchAttrs') {

			$Request[$Collection] = @($Request[$Collection])

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty excludedHiddenOpAttrs, logsExcludedAttrs, binaryAttrs, excludedAttrs, multiValuedAttrs, keywordSearchAttrs

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Global Attribute Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
