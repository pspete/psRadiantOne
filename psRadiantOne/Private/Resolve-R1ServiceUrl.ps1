function Resolve-R1ServiceUrl {
	<#
	.SYNOPSIS
	Composes the request URL for a RadiantOne API service.

	.DESCRIPTION
	The RadiantOne API is divided across a number of service path prefixes, each of which sits
	directly under the base URL of the RadiantOne deployment.

	This function is the single place those prefixes are defined, so that no command needs to
	hardcode one. Given a service key and the path of an operation within that service, it returns
	the complete request URL, using the BaseURI held in the module scope session.

	.PARAMETER Service
	The RadiantOne service hosting the operation.

	.PARAMETER Path
	The path of the operation within the service, with or without a leading forward slash.
	Any path parameter values must already be escaped by the caller.

	.PARAMETER BaseURI
	The base URL of the RadiantOne deployment. Defaults to the BaseURI of the module scope session.

	.EXAMPLE
	Resolve-R1ServiceUrl -Service Settings -Path 'dashboard'

	Returns https://radiantone.company.com/settings-service/dashboard

	.EXAMPLE
	Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)"

	Returns the naming context URL for the escaped dn.

	.OUTPUTS
	System.String
	#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			Position = 0
		)]
		[ValidateSet(
			'Auth',
			'Settings',
			'Namespace',
			'Catalog',
			'Browser',
			'Schema',
			'SysAdmin'
		)]
		[string]$Service,

		[parameter(
			Mandatory = $false,
			Position = 1
		)]
		[AllowEmptyString()]
		[string]$Path,

		[parameter(Mandatory = $false)]
		[string]$BaseURI = $Script:psRadiantOneSession.BaseURI
	)

	Process {

		$ServicePath = switch ($Service) {

			'Auth' { 'authentication-service' }
			'Settings' { 'settings-service' }
			'Namespace' { 'directory-namespace-service' }
			'Catalog' { 'data-catalog-service' }
			'Browser' { 'directory-browser-service' }
			'Schema' { 'directory-schema-service' }
			'SysAdmin' { 'system-administration-service' }

		}

		$Url = "$($BaseURI -replace '/$', '')/$ServicePath"

		if (-not ([string]::IsNullOrEmpty($Path))) {

			$Url = "$Url/$($Path -replace '^/', '')"

		}

		$Url

	}

}
