# .ExternalHelp psRadiantOne-help.xml
function New-R1FIDRole {
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
		[hashtable]$exportImportPermissions,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$roleToClone
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'roles'

		if ($PSBoundParameters.ContainsKey('roleToClone')) {

			$Path = "$Path`?roleToClone=$($roleToClone | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Auth -Path $Path

		$Body = $PSBoundParameters | Get-Parameter -ParametersToRemove roleToClone | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, 'Create FID Role')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
