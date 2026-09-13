# .ExternalHelp psRadiantOne-help.xml
function New-R1Schema {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('schemaName')]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('LDAP', 'DATABASE', 'CUSTOM')]
		[string]$type,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dataSourceName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$baseDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$publishToServer,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$objects
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'schemas'

		$Request = $PSBoundParameters | Get-Parameter

		if ($Request.Contains('objects')) {

			$Request['objects'] = @($Request['objects'])

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, 'Create Schema')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
