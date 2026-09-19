# .ExternalHelp psRadiantOne-help.xml
function New-R1ComputedAttributeExpression {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
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
		[string]$signature,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNull()]
		[System.Collections.IDictionary]$values
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/object_builder/primary_objects/$($primaryObject | Get-EscapedString)/computed_attr_functions"

		$Body = [ordered]@{
			signature = $signature
			values    = @($values.Keys | ForEach-Object { [ordered]@{ name = "$PSItem"; value = "$($values[$PSItem])" } })
		} | ConvertTo-R1JsonBody -EmptyArrayProperty values

		if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", "Build Expression from '$signature'")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result.expression

			}

		}

	}#process

	End { }#end

}
