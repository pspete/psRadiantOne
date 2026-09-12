# .ExternalHelp psRadiantOne-help.xml
function Get-R1AttributeEncryption {
	[CmdletBinding()]
	[OutputType('psRadiantOne.AttributeEncryption')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'attribute_encryption'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.AttributeEncryption

		}

	}#process

	End { }#end

}
