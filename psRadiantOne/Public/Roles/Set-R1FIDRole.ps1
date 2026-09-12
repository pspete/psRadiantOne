# .ExternalHelp psRadiantOne-help.xml
function Set-R1FIDRole {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 1000)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$entryDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('NONE', 'VIEW', 'EDIT')]
		[string]$directoryBrowserPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$directoryNamespacePermissions,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('NONE', 'VIEW', 'EDIT')]
		[string]$identityManagerPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$securityPermissions,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$classicControlPanelPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('NONE', 'VIEW', 'EDIT')]
		[string]$tasksPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$settingsPermissions,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$tuningPermissions,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('NONE', 'VIEW', 'EDIT')]
		[string]$globalSyncPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('NONE', 'VIEW', 'EDIT')]
		[string]$observabilityPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('NONE', 'VIEW', 'EDIT')]
		[string]$dashboardPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('NONE', 'VIEW', 'EDIT')]
		[string]$fileManagerPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$revokeTokenPermission,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$dataCatalogPermissions,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$administrationPermissions,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[hashtable]$exportImportPermissions
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path "roles/$($name | Get-EscapedString)"

		#The API resets any permission absent from the request to NONE, and the control panel sends
		#back the complete role it retrieved. Do the same, so that a permission left unspecified keeps
		#its current value rather than being silently cleared.
		$Existing = Get-R1FIDRole -name $name

		#Key order follows the request the control panel sends. entryDn and defaultRole are omitted
		#from it, so they are not sent back unless entryDn is given explicitly.
		$Template = [ordered]@{
			directoryBrowserPermission    = 'NONE'
			identityManagerPermission     = 'NONE'
			tasksPermission               = 'NONE'
			globalSyncPermission          = 'NONE'
			observabilityPermission       = 'NONE'
			dashboardPermission           = 'NONE'
			fileManagerPermission         = 'NONE'
			dataCatalogPermissions        = $null
			securityPermissions           = $null
			directoryNamespacePermissions = $null
			tuningPermissions             = $null
			exportImportPermissions       = $null
			settingsPermissions           = $null
			administrationPermissions     = $null
			classicControlPanelPermission = $null
			revokeTokenPermission         = $false
			name                          = $name
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove entryDn) -Fallback $Existing

		if ($PSBoundParameters.ContainsKey('entryDn')) {

			$Request['entryDn'] = $entryDn

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, 'Update FID Role')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
