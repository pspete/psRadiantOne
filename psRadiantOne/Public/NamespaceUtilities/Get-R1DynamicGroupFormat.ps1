# .ExternalHelp psRadiantOne-help.xml
function Get-R1DynamicGroupFormat {
	[CmdletBinding()]
	[OutputType('psRadiantOne.DynamicGroupFormat')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dynamicGroupDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$QueryString = $PSBoundParameters | Get-Parameter | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/special_attributes_utils/dynamic_group_format?$QueryString"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.DynamicGroupFormat

		}

	}#process

	End { }#end

}
