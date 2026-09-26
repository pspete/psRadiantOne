# .ExternalHelp psRadiantOne-help.xml
function New-R1ComputedAttributeExpression {
	[CmdletBinding(DefaultParameterSetName = 'Value', SupportsShouldProcess, ConfirmImpact = 'Low')]
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
			ParameterSetName = 'Value',
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNull()]
		[string[]]$value = @(),

		[parameter(
			ParameterSetName = 'Values',
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

		if ($PSCmdlet.ParameterSetName -eq 'Value') {

			#The server substitutes values positionally, so they are named from the function's own
			#parameter list rather than left to the order a dictionary happens to enumerate in
			$Function = Get-R1ComputedAttributeFunction -dn $dn -primaryObject $primaryObject |
				Where-Object { $PSItem.signature -eq $signature }

			if ($null -eq $Function) {

				throw "Computed attribute function '$signature' not found on $dn ($primaryObject)."

			}

			$Parameter = @($Function.parameters)
			$Required = @($Parameter | Where-Object { $PSItem.required }).Count

			if ($value.Count -lt $Required -or $value.Count -gt $Parameter.Count) {

				throw "'$signature' takes $Required required and $($Parameter.Count) total values, $($value.Count) supplied."

			}

			$values = [ordered]@{}

			for ($i = 0; $i -lt $value.Count; $i++) {

				$values[$Parameter[$i].name] = $value[$i]

			}

		}

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
