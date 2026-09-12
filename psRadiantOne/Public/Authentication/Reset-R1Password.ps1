# .ExternalHelp psRadiantOne-help.xml
function Reset-R1Password {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$resetToken,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNull()]
		[securestring]$newPassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[securestring]$currentPassword
	)

	Begin {

		Assert-R1Session

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'password_reset'

		$Request = [ordered]@{
			resetToken  = $resetToken
			newPassword = $newPassword | ConvertTo-InsecureString
		}

		if ($PSBoundParameters.ContainsKey('currentPassword')) {

			$Request.Add('currentPassword', ($currentPassword | ConvertTo-InsecureString))

		}

		$Body = $Request | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Reset Expired Password')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
