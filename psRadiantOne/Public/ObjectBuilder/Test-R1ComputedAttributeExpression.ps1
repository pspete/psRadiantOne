# .ExternalHelp psRadiantOne-help.xml
function Test-R1ComputedAttributeExpression {
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$primaryObject,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 10000)]
		[string]$expression,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$attributes
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/object_builder/primary_objects/$($primaryObject | Get-EscapedString)/computed_attr_functions/validate_expression"

		$Body = [ordered]@{
			attributes = [string[]]@($attributes | Where-Object { $PSItem })
			#The API compiles the attribute and its expression together, as name=expression
			expression = "$name=$expression"
		} | ConvertTo-R1JsonBody -EmptyArrayProperty attributes

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			if ((-not $Result.isValid) -and (-not ([string]::IsNullOrEmpty($Result.errorMsg)))) {

				Write-Verbose $Result.errorMsg

			}

			$Result.isValid

		}

	}#process

	End { }#end

}
