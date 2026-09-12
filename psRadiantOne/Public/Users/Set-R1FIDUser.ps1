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
			Mandatory = $false,
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

		$URI = Resolve-R1ServiceUrl -Service Auth -Path "users/$($username | Get-EscapedString)"

		#The control panel updates a user by sending back the complete object it retrieved, including
		#the properties the api maintains itself. Do the same, so that a property left unspecified
		#keeps its current value instead of relying on the endpoint to merge.
		$Existing = Get-R1FIDUser -username $username

		$Template = [ordered]@{
			username     = $username
			firstName    = $null
			lastName     = $null
			entryDn      = $null
			email        = $null
			active       = $true
			roles        = @()
			server       = $null
			organization = $null
			createdOn    = $null
			assumeRole   = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove password) -Fallback $Existing

		if ($PSBoundParameters.ContainsKey('roles')) {

			$Request['roles'] = @($roles)

		}

		if ($PSBoundParameters.ContainsKey('password')) {

			#An absent password leaves the existing password unchanged
			$Request['password'] = $password | ConvertTo-InsecureString

		}

		$Body = $Request | ConvertTo-R1SecretBody -EmptyArrayProperty roles

		if ($PSCmdlet.ShouldProcess($username, 'Update FID User')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
