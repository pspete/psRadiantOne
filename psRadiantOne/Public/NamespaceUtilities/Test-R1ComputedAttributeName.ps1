# .ExternalHelp psRadiantOne-help.xml
function Test-R1ComputedAttributeName {
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[string]$computedAttributeName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$QueryString = $PSBoundParameters | Get-Parameter | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_context_utils/validate_computed_attr_name?$QueryString"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			if ((-not $Result.isValid) -and (-not ([string]::IsNullOrEmpty($Result.errorMsg)))) {

				Write-Verbose $Result.errorMsg

			}

			$Result.isValid

		}

	}#process

	End { }#end

}
