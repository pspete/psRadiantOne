# .ExternalHelp psRadiantOne-help.xml
function New-R1DirectoryADUser {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Settings')]
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
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$sn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$givenName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$changePasswordAtNextLogon,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Settings'
		)]
		[bool]$cannotChangePassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Settings'
		)]
		[bool]$passwordNeverExpires,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Settings'
		)]
		[bool]$accountDisabled,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'UserAccountControl'
		)]
		[int]$userAccountControl
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$dn = "$(ConvertTo-R1Rdn -Attribute cn -Value $cn),$parentDn"

		$Entry = $PSBoundParameters | Get-Parameter -ParametersToKeep cn, sAMAccountName, givenName, sn
		$Entry['objectClass'] = 'top', 'person', 'organizationalPerson', 'user'

		if ($PSCmdlet.ParameterSetName -eq 'Settings') {

			#NORMAL_ACCOUNT, plus ACCOUNTDISABLE, PASSWD_CANT_CHANGE and DONT_EXPIRE_PASSWORD
			$userAccountControl = 0x200
			if ($accountDisabled) { $userAccountControl = $userAccountControl -bor 0x2 }
			if ($cannotChangePassword) { $userAccountControl = $userAccountControl -bor 0x40 }
			if ($passwordNeverExpires) { $userAccountControl = $userAccountControl -bor 0x10000 }

		}

		$Entry['userAccountControl'] = "$userAccountControl"

		if ($changePasswordAtNextLogon) {
			$Entry['pwdLastSet'] = '0'
		}

		if ($PSBoundParameters.ContainsKey('password')) {
			$Entry['unicodePwd'] = $password | ConvertTo-InsecureString
		}

		if ($PSCmdlet.ShouldProcess($dn, 'Add Active Directory User')) {

			New-R1DirectoryEntry -dn $dn -attributes $Entry -Confirm:$false

		}

	}#process

	End { }#end

}
