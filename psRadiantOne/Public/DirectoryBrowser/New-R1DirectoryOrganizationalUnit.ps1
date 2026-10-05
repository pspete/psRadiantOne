# .ExternalHelp psRadiantOne-help.xml
function New-R1DirectoryOrganizationalUnit {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$ou,

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
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$telephoneNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$facsimileTelephoneNumber,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$postalAddress
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$dn = "$(ConvertTo-R1Rdn -Attribute ou -Value $ou),$parentDn"

		$Entry = $PSBoundParameters | Get-Parameter -ParametersToRemove ou, parentDn
		$Entry['objectClass'] = 'top', 'organizationalUnit'

		if ($PSCmdlet.ShouldProcess($dn, 'Add Organizational Unit')) {

			New-R1DirectoryEntry -dn $dn -attributes $Entry -Confirm:$false

		}

	}#process

	End { }#end

}
