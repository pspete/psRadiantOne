# .ExternalHelp psRadiantOne-help.xml
function Set-R1FIDUser {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[a-zA-Z0-9_-]+$')]
		[string]$username,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 1000)]
		[string]$firstName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 1000)]
		[string]$lastName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 10000)]
		[string]$email
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path "users/$($username | Get-EscapedString)"

		$Request = $PSBoundParameters | Get-Parameter

		if ($PSBoundParameters.ContainsKey('password')) {

			#An absent password leaves the existing password unchanged
			$Request['password'] = $password | ConvertTo-InsecureString

		}

		$Body = $Request | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($username, 'Update FID User')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
