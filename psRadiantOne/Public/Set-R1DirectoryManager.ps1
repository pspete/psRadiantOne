# .ExternalHelp psRadiantOne-help.xml
function Set-R1DirectoryManager {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 1000)]
		[string]$userName,

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

		$Request = $PSBoundParameters | Get-Parameter
		$Request['password'] = $password | ConvertTo-InsecureString

		if ($PSBoundParameters.ContainsKey('oldPassword')) {

			$Request['oldPassword'] = $oldPassword | ConvertTo-InsecureString

		}

		if ($PSBoundParameters.ContainsKey('allowedIps')) {

			$Request['allowedIps'] = @($allowedIps)

		}

		$Body = $Request | ConvertTo-R1SecretBody -EmptyArrayProperty allowedIps

		if ($PSCmdlet.ShouldProcess($userName, 'Update Directory Manager Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
