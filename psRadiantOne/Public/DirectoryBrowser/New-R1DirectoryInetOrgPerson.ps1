# .ExternalHelp psRadiantOne-help.xml
function New-R1DirectoryInetOrgPerson {
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
		[string]$sn,

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
		[ValidateSet('cn', 'uid')]
		[string]$namingAttribute = 'cn',

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$uid,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$givenName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$mail,

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
		[ValidateNotNull()]
		[securestring]$password
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if (($namingAttribute -eq 'uid') -and [string]::IsNullOrEmpty($uid)) {
			throw 'A uid must be given to name the entry by its uid'
		}

		$dn = "$(ConvertTo-R1Rdn -Attribute $namingAttribute -Value $PSBoundParameters[$namingAttribute]),$parentDn"

		$Entry = $PSBoundParameters | Get-Parameter -ParametersToRemove parentDn, namingAttribute, password
		$Entry['objectClass'] = 'top', 'person', 'organizationalPerson', 'inetOrgPerson'

		if ($PSBoundParameters.ContainsKey('password')) {
			$Entry['userPassword'] = $password | ConvertTo-InsecureString
		}

		if ($PSCmdlet.ShouldProcess($dn, 'Add inetOrgPerson')) {

			New-R1DirectoryEntry -dn $dn -attributes $Entry -Confirm:$false

		}

	}#process

	End { }#end

}
