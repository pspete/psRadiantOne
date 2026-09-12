# .ExternalHelp psRadiantOne-help.xml
function New-R1InterceptionScriptJar {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.InterceptionJarBuildResults')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'interception_scripts/build_jar'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Build Interception Script Jar')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.InterceptionJarBuildResults

			}

		}

	}#process

	End { }#end

}
