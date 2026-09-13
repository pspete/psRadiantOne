# .ExternalHelp psRadiantOne-help.xml
function Clear-R1Library {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType('psRadiantOne.LibraryCleanResult')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'libraries/clean'

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Remove Unreferenced Libraries')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.LibraryCleanResult

			}

		}

	}#process

	End { }#end

}
