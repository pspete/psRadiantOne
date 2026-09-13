# .ExternalHelp psRadiantOne-help.xml
function Reset-R1DirectoryEntryPassword {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[securestring]$password
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Browser -Path "directory_browser/$($dn | Get-EscapedString)/reset_password"

		#The request body is the password itself, as a json string
		$Body = ConvertTo-R1SecretBody -InputObject ($password | ConvertTo-InsecureString)

		if ($PSCmdlet.ShouldProcess($dn, 'Reset Password')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
