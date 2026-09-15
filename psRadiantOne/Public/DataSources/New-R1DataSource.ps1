# .ExternalHelp psRadiantOne-help.xml
function New-R1DataSource {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Ldap')]
	[OutputType([void])]
	param(
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
		[ValidateNotNullOrEmpty()]
		[string]$type,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$defaultSchema,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$addedSchemas,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$groupId,

		#--------------------------------------------------------------------------------- ldap
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('host')]
		[string]$hostName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[int]$port,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$bindDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[bool]$ssl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[string]$baseDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[bool]$pagedResultsControl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[ValidateRange(0, 100000)]
		[int]$pageSize,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[bool]$chaseReferrals,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[object[]]$failovers,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[bool]$verifySslHostname,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[string]$kerberosProfile,

		#----------------------------------------------------------------------------- database
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$driverClassName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$url,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$username,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[string]$failOverName,

		#------------------------------------------------------------------------------- custom
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Custom'
		)]
		[ValidateNotNull()]
		[hashtable]$customProps,

		#------------------------------------------------------------------ database and custom
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Custom'
		)]
		[string]$onPremHost,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Custom'
		)]
		[int]$onPremPort,

		#-------------------------------------------------------------------- ldap and database
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Ldap'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Database'
		)]
		[securestring]$password
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'data_sources'

		$Request = $PSBoundParameters | Get-Parameter -ParametersToRemove password

		#category is the discriminator the API uses to choose the data source shape
		$Request['category'] = $PSCmdlet.ParameterSetName.ToLowerInvariant()

		#host is an automatic variable, so the parameter is hostName and the key is renamed here
		if ($Request.Contains('hostName')) {

			$Request['host'] = $Request['hostName']
			$null = $Request.Remove('hostName')

		}

		foreach ($Collection in 'addedSchemas', 'failovers') {

			if ($null -ne $Request[$Collection]) {

				$Request[$Collection] = @($Request[$Collection])

			}

		}

		if ($PSBoundParameters.ContainsKey('password')) {

			$Request['password'] = $password | ConvertTo-InsecureString

		}

		$Body = $Request | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($name, "Create $($PSCmdlet.ParameterSetName) Data Source")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
