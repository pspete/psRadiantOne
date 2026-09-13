# .ExternalHelp psRadiantOne-help.xml
function Invoke-R1SchemaDiff {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('SAVE_AS_NEW', 'UPDATE')]
		[string]$applyType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$oldSchemaName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$newSchemaName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isLdap,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('dataSourceName')]
		[string]$datasource,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$objects,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[object[]]$changes
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'schema_diff'

		$Request = $PSBoundParameters | Get-Parameter

		foreach ($Collection in 'objects', 'changes') {

			$Request[$Collection] = @($Request[$Collection])

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($oldSchemaName, "Apply Schema Changes ($applyType)")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
