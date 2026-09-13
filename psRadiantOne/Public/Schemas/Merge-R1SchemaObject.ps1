# .ExternalHelp psRadiantOne-help.xml
function Merge-R1SchemaObject {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.Table')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$schemaName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$sourceTable,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$mergedViewName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$objectsToMerge
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/merge_objects"

		$Request = $PSBoundParameters | Get-Parameter -ParametersToRemove schemaName

		$Request['objectsToMerge'] = @($Request['objectsToMerge'])

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($mergedViewName, 'Merge Objects')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.Table

			}

		}

	}#process

	End { }#end

}
