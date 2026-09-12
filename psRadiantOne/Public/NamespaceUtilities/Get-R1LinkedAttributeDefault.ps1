# .ExternalHelp psRadiantOne-help.xml
function Get-R1LinkedAttributeDefault {
	[CmdletBinding()]
	[OutputType('psRadiantOne.LinkedAttributeDefault')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'naming_contexts/special_attributes_utils/linked_attributes_defaults'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LinkedAttributeDefault

		}

	}#process

	End { }#end

}
