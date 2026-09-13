# .ExternalHelp psRadiantOne-help.xml
function New-R1DataSourceTypeImportMeta {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.DataSourceType')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$importId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[object]$DataSourceType
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "meta/import/$($importId | Get-EscapedString)/meta"

		$Body = $DataSourceType | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($importId, "Add Template $($DataSourceType.name)")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.DataSourceType

			}

		}

	}#process

	End { }#end

}
