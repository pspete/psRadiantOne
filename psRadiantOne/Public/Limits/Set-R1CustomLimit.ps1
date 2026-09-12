# .ExternalHelp psRadiantOne-help.xml
function Set-R1CustomLimit {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false
		)]
		[AllowEmptyCollection()]
		[hashtable[]]$limits
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'limits/custom'

		if ($limits.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($limits)

		}

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, "Replace Custom Limits ($($limits.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
