# .ExternalHelp psRadiantOne-help.xml
function Get-R1DirectorySchemaFile {
	[CmdletBinding()]
	[OutputType('System.String')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Schema -Path 'files'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result

		}

	}#process

	End { }#end

}
