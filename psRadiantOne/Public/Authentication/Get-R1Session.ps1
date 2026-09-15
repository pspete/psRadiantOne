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

		#Returned as an object rather than the dictionary it is held as, so that its keys are
		#properties: Select-Object and the format view both read properties, and on a dictionary
		#would find only Keys, Values and Count.
		[pscustomobject]$Session | Add-CustomType -Type psRadiantOne.Session

	}#process

	End { }#end

}
