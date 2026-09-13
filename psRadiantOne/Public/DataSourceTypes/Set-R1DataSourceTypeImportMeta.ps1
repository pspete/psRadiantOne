# .ExternalHelp psRadiantOne-help.xml
function Set-R1DataSourceTypeImportMeta {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
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
		[ValidateNotNullOrEmpty()]
		[string]$name,

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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "meta/import/$($importId | Get-EscapedString)/meta/$($name | Get-EscapedString)"

		$Body = $DataSourceType | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, 'Update Import Template')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
