# .ExternalHelp psRadiantOne-help.xml
function Get-R1JoinCondition {
	[CmdletBinding()]
	[OutputType('psRadiantOne.JoinConditionObject')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$secondaryObject,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[string]$primaryJoinAttribute,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[string]$secondaryJoinAttribute
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$QueryString = $PSBoundParameters | Get-Parameter | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_context_utils/build_join_condition?$QueryString"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.JoinConditionObject

		}

	}#process

	End { }#end

}
