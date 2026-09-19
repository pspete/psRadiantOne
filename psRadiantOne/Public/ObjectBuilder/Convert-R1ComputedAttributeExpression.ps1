# .ExternalHelp psRadiantOne-help.xml
function Convert-R1ComputedAttributeExpression {
	[CmdletBinding()]
	[OutputType('System.String')]
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
		[ValidateLength(1, 10000)]
		[string]$previousAttrName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 10000)]
		[string]$newAttrName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$expressions
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/object_builder/primary_objects/$($primaryObject | Get-EscapedString)/computed_attr_functions/remap_attribute"

		$Body = [ordered]@{
			previousAttrName = $previousAttrName
			newAttrName      = $newAttrName
			expressions      = [string[]]@($expressions)
		} | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result.expressions

		}

	}#process

	End { }#end

}
