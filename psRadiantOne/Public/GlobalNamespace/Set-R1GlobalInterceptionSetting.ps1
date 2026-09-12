# .ExternalHelp psRadiantOne-help.xml
function Set-R1GlobalInterceptionSetting {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('BIND', 'MODIFY', 'DELETE', 'ADD', 'COMPARE', 'SEARCH', 'SPECIAL_OPERATION')]
		[string[]]$preOperationInterceptOn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('BIND', 'MODIFY', 'DELETE', 'ADD', 'SEARCH_RESULT_ENTRY_PROCESSING')]
		[string[]]$postOperationInterceptAfter
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'global_interception_settings'

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so an operation list left unspecified keeps its current value.
		$Existing = Get-R1GlobalInterceptionSetting

		$Template = [ordered]@{
			javaClassName               = $null
			preOperationInterceptOn     = @()
			postOperationInterceptAfter = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		foreach ($Collection in 'preOperationInterceptOn', 'postOperationInterceptAfter') {

			$Request[$Collection] = @($Request[$Collection])

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty preOperationInterceptOn, postOperationInterceptAfter

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Global Interception Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
