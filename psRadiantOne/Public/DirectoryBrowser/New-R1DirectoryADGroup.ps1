# .ExternalHelp psRadiantOne-help.xml
function New-R1DirectoryADGroup {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$groupName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$parentDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('Global', 'DomainLocal', 'Universal')]
		[string]$groupScope = 'Global',

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('Security', 'Distribution')]
		[string]$groupCategory = 'Security',

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$description
	)

	Begin {

		Assert-R1Session -RequireToken

		$Scope = @{
			Global      = @{ Name = 'globalGroup'; Flag = 0x2 }
			DomainLocal = @{ Name = 'domainLocalGroup'; Flag = 0x4 }
			Universal   = @{ Name = 'universalGroup'; Flag = 0x8 }
		}

	}#begin

	Process {

		$dn = "$(ConvertTo-R1Rdn -Attribute cn -Value $groupName),$parentDn"

		#ADS_GROUP_TYPE_SECURITY_ENABLED is the sign bit, so a security group's type is negative
		$groupType = $Scope[$groupScope].Flag
		if ($groupCategory -eq 'Security') { $groupType = $groupType -bor [int]::MinValue }

		$Entry = $PSBoundParameters | Get-Parameter -ParametersToKeep groupName, description
		$Entry['objectClass'] = 'top', 'group'
		$Entry['groupScope'] = $Scope[$groupScope].Name
		$Entry['groupType'] = "$groupType"

		if ($PSCmdlet.ShouldProcess($dn, 'Add Active Directory Group')) {

			New-R1DirectoryEntry -dn $dn -attributes $Entry -Confirm:$false

		}

	}#process

	End { }#end

}
