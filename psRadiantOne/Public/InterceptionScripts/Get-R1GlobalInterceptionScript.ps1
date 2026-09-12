# .ExternalHelp psRadiantOne-help.xml
function Get-R1GlobalInterceptionScript {
	[CmdletBinding()]
	[OutputType('psRadiantOne.InterceptionScriptContents')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'interception_scripts/global'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.InterceptionScriptContents

		}

	}#process

	End { }#end

}
