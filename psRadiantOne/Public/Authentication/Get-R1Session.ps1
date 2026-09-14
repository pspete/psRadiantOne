# .ExternalHelp psRadiantOne-help.xml
function Get-R1Session {
	[CmdletBinding()]
	[OutputType('psRadiantOne.Session')]
	param( )

	Begin { }#begin

	Process {

		$Session = $Script:psRadiantOneSession | Get-SessionClone

		#How long the session has been open is only meaningful at the moment it is asked for, so it
		#is calculated here rather than held in the session object.
		if ($null -ne $Session['StartTime']) {

			$Session['ElapsedTime'] = '{0:hh\:mm\:ss}' -f ((Get-Date) - $Session['StartTime'])

		}

		$Session | Add-CustomType -Type psRadiantOne.Session

	}#process

	End { }#end

}
