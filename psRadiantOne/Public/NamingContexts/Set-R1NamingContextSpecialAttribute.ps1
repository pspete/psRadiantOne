# .ExternalHelp psRadiantOne-help.xml
function Set-R1NamingContextSpecialAttribute {
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
		[object[]]$linkedAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object]$dynamicGroupSettings,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$unnestGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$referentialIntegrityRules,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$attributeUniquenessRules
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/special_attributes"

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so a setting left unspecified keeps its current value.
		$Existing = Get-R1NamingContextSpecialAttribute -dn $dn

		$Template = [ordered]@{
			linkedAttributes          = @()
			dynamicGroupSettings      = $null
			unnestGroups              = @()
			referentialIntegrityRules = @()
			attributeUniquenessRules  = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn) -Fallback $Existing

		foreach ($Collection in 'linkedAttributes', 'unnestGroups', 'referentialIntegrityRules', 'attributeUniquenessRules') {

			$Request[$Collection] = @($Request[$Collection])

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty linkedAttributes, unnestGroups, referentialIntegrityRules, attributeUniquenessRules

		if ($PSCmdlet.ShouldProcess($dn, 'Update Special Attributes')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
