# .ExternalHelp psRadiantOne-help.xml
function Get-R1ServiceSummary {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ServiceSummary')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'dashboard/service_summary'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ServiceSummary

		}

	}#process

	End { }#end

}
