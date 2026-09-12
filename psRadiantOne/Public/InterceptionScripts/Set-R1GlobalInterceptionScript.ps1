# .ExternalHelp psRadiantOne-help.xml
function Set-R1GlobalInterceptionScript {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 100000)]
		[string]$scriptContents,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$classname,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$filename
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'interception_scripts/global'

		#Retrieve the current script and send it back with the supplied values applied over it, so
		#a property left unspecified keeps its current value.
		$Existing = Get-R1GlobalInterceptionScript

		$Template = [ordered]@{
			classname      = $null
			filename       = $null
			scriptContents = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Global Interception Script')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
