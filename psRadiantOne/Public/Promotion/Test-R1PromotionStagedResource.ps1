# .ExternalHelp psRadiantOne-help.xml
function Test-R1PromotionStagedResource {
	[CmdletBinding()]
	[OutputType('psRadiantOne.StagedPromotionResourceValidationResult')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[object]$StagedResources
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'configuration/export/auto/stage/validate'

		$Body = $StagedResources | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.StagedPromotionResourceValidationResult

		}

	}#process

	End { }#end

}
