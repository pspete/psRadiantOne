# .ExternalHelp psRadiantOne-help.xml
function Get-R1AuditLogSetting {
	[CmdletBinding()]
	[OutputType('psRadiantOne.AuditLogConfiguration')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'audit_logs/configuration'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.AuditLogConfiguration

		}

	}#process

	End { }#end

}
