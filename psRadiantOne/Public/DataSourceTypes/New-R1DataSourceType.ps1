# .ExternalHelp psRadiantOne-help.xml
function New-R1DataSourceType {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Ldap')]
	[OutputType('psRadiantOne.DataSourceType')]
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

		#--------------------------------------------------------------------------------- ldap
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[bool]$isLdap,

		#----------------------------------------------------------------------------- database
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$driverClass,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[ValidateLength(1, 500)]
		[string]$urlPattern,

		#------------------------------------------------------------------------------- custom
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Custom'
		)]
		[ValidateLength(1, 500)]
		[string]$javaClassName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Custom'
		)]
		[string]$pluginName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Custom'
		)]
		[object[]]$meta
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'meta/data_source_types'

		$Request = $PSBoundParameters | Get-Parameter

		#backendCategory is the discriminator the API uses to choose the template shape
		$Request['backendCategory'] = $PSCmdlet.ParameterSetName.ToLowerInvariant()

		if ($Request.Contains('meta')) {

			$Request['meta'] = @($Request['meta'])

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, "Create $($PSCmdlet.ParameterSetName) Data Source Type")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.DataSourceType

			}

		}

	}#process

	End { }#end

}
