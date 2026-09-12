# .ExternalHelp psRadiantOne-help.xml
function New-R1FIDUser {
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
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNull()]
		[securestring]$password,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$active,

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
		[string]$email,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$roles
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'users'

		$Request = $PSBoundParameters | Get-Parameter
		$Request['password'] = $password | ConvertTo-InsecureString

		if ($PSBoundParameters.ContainsKey('roles')) {

			$Request['roles'] = @($roles)

		}

		$Body = $Request | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($username, 'Create FID User')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
