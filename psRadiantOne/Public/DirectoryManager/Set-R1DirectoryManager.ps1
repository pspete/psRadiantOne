# .ExternalHelp psRadiantOne-help.xml
function Set-R1DirectoryManager {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$username,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNull()]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[securestring]$oldPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$allowedIps
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'directory_manager'

		#Retrieve the current settings and send them back with the supplied values applied over them,
		#as the other settings endpoints require. Sending only the supplied values risks clearing the
		#allowed IP list of the directory manager account.
		$Existing = Get-R1DirectoryManager

		$Template = [ordered]@{
			username   = $null
			allowedIps = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove password, oldPassword) -Fallback $Existing

		if ($PSBoundParameters.ContainsKey('allowedIps')) {

			$Request['allowedIps'] = @($allowedIps)

		} else {

			$Request['allowedIps'] = @($Existing.allowedIps)

		}

		$Request['password'] = $password | ConvertTo-InsecureString

		if ($PSBoundParameters.ContainsKey('oldPassword')) {

			$Request['oldPassword'] = $oldPassword | ConvertTo-InsecureString

		}

		$Body = $Request | ConvertTo-R1SecretBody -EmptyArrayProperty allowedIps

		if ($PSCmdlet.ShouldProcess($Request['username'], 'Update Directory Manager Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
