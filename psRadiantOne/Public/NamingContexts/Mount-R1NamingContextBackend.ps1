# .ExternalHelp psRadiantOne-help.xml
function Mount-R1NamingContextBackend {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
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
		[string]$datasource,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'LdapProxy'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$remoteBaseDn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'DbProxy'
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$tableViews,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'DbProxy'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$schema,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'DbProxy'
		)]
		[bool]$isQuoteTableNames = $false,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'DbProxy'
		)]
		[bool]$isQuoteColumnNames = $false
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/mount_backend"

		switch ($PSCmdlet.ParameterSetName) {

			'LdapProxy' {

				$Request = [ordered]@{
					backendType  = 'LDAP_PROXY'
					datasource   = $datasource
					remoteBaseDn = $remoteBaseDn
				}

			}

			'DbProxy' {

				$Request = [ordered]@{
					backendType = 'DB_PROXY'
					datasource  = $datasource
				}

				if ($PSBoundParameters.ContainsKey('schema')) {

					$Request['schema'] = $schema

				}

				$Request['isQuoteTableNames'] = $isQuoteTableNames
				$Request['isQuoteColumnNames'] = $isQuoteColumnNames
				$Request['tableViews'] = [string[]]@($tableViews)

			}

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, "Mount $($Request['backendType']) Backend")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
