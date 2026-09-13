# .ExternalHelp psRadiantOne-help.xml
function New-R1SchemaDerivedView {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.DerivedObjects')]
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
		[ValidateLength(1, 500)]
		[string]$field
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/derive_view"

		$Body = $PSBoundParameters | Get-Parameter -ParametersToRemove schemaName | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($sourceTable, "Derive View on $field")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.DerivedObjects

			}

		}

	}#process

	End { }#end

}
