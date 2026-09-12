# .ExternalHelp psRadiantOne-help.xml
function Test-R1JoinCondition {
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$joinCondition
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$QueryString = $PSBoundParameters | Get-Parameter | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_context_utils/validate_join_condition?$QueryString"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result.isValid

		}

	}#process

	End { }#end

}
