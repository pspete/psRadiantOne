# .ExternalHelp psRadiantOne-help.xml
function New-R1DirectoryGroup {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$cn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$parentDn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$sAMAccountName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('group', 'groupOfNames', 'groupOfUniqueNames')]
		[string]$type = 'group',

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$dynamic
	)

	Begin {

		Assert-R1Session -RequireToken

		$ObjectClass = @{
			group              = 'group'
			groupOfNames       = 'groupOfNames'
			groupOfUniqueNames = 'groupOfUniqueNames'
		}

	}#begin

	Process {

		$dn = "$(ConvertTo-R1Rdn -Attribute cn -Value $cn),$parentDn"

		$Entry = $PSBoundParameters | Get-Parameter -ParametersToRemove parentDn, type, dynamic
		$Entry['objectClass'] = @('top', $ObjectClass[$type])
		if ($dynamic) { $Entry['objectClass'] += 'groupOfURLs' }

		if ($PSCmdlet.ShouldProcess($dn, 'Add Group')) {

			New-R1DirectoryEntry -dn $dn -attributes $Entry -Confirm:$false

		}

	}#process

	End { }#end

}
