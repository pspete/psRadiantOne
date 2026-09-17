# .ExternalHelp psRadiantOne-help.xml
function Set-R1DataSourceType {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[string]$icon,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isLdap,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$driverClass,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$urlPattern,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$javaClassName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$pluginName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$meta
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "meta/data_source_types/$($name | Get-EscapedString)"

		#Retrieve the template and send it back with the supplied values applied over it, so a
		#property left unspecified keeps its current value.
		$Existing = Get-R1DataSourceType -name $name

		#The properties differ by backend category, so the request is built from what the API
		#returned rather than from a fixed list.
		$Template = [ordered]@{ }

		foreach ($Property in $Existing.psobject.Properties) {

			$Template[$Property.Name] = $Property.Value

		}

		$Bound = $PSBoundParameters | Get-Parameter

		foreach ($Key in $Bound.Keys) {

			$Template[$Key] = $Bound[$Key]

		}

		#A null meta stays null. Wrapped, it becomes a collection holding nothing, which the API can
		#store and then never read back.
		if ($null -ne $Template['meta']) {

			$Template['meta'] = @($Template['meta'])

		}

		$Body = $Template | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, 'Update Data Source Type')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
