# .ExternalHelp psRadiantOne-help.xml
function Set-R1NamingContextVirtualTreeProperty {
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
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$directoryView,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isActive,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('LDAP', 'DATABASE', 'CUSTOM')]
		[string]$dataSourceType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$dataSourceName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$virtualAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$baseDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/virtual_tree/properties"

		#Retrieve the current properties and send them back with the supplied values applied over
		#them, so a property left unspecified keeps its current value.
		$Existing = Get-R1NamingContextVirtualTreeProperty -dn $dn

		#namingContext and schema are maintained by the API and are sent back unchanged
		$Template = [ordered]@{
			namingContext     = $null
			directoryView     = $null
			schema            = $null
			isActive          = $true
			dataSourceType    = $null
			dataSourceName    = $null
			virtualAttributes = @()
			baseDn            = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn) -Fallback $Existing

		$Request['virtualAttributes'] = @($Request['virtualAttributes'])

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty virtualAttributes

		if ($PSCmdlet.ShouldProcess($dn, 'Update Virtual Tree Properties')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
