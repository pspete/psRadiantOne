# .ExternalHelp psRadiantOne-help.xml
function Read-R1License {
	[CmdletBinding()]
	[OutputType('psRadiantOne.LicenseInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$license
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'license/read'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LicenseInfo

		}

	}#process

	End { }#end

}
