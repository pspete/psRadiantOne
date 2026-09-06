# .ExternalHelp psRadiantOne-help.xml
function Get-R1DirectoryManager {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DirectoryManager')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'directory_manager'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DirectoryManager

		}

	}#process

	End { }#end

}
