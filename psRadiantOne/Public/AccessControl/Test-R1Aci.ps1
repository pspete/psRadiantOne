# .ExternalHelp psRadiantOne-help.xml
function Test-R1Aci {
	[CmdletBinding()]
	[OutputType('psRadiantOne.Aci')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 50000)]
		[string]$aciString
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'access_control/acis/validate_parsable'

		#The request body is the aci string itself. The endpoint reads what it is sent without
		#parsing it as json, so a json encoded value is taken as part of the aci and the answer
		#comes back unparsable.
		#The endpoint is a GET which carries the aci as its request body.
		$Result = Invoke-R1RestMethod -Uri $URI -Method GET -Body $aciString

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Aci

		}

	}#process

	End { }#end

}
