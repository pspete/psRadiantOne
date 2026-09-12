# .ExternalHelp psRadiantOne-help.xml
function Get-R1Session {
	[CmdletBinding()]
	[OutputType('psRadiantOne.Session')]
	param( )

	Begin { }#begin

	Process {

		$Script:psRadiantOneSession | Get-SessionClone | Add-CustomType -Type psRadiantOne.Session

	}#process

	End { }#end

}
