# .ExternalHelp psRadiantOne-help.xml
function Update-R1AttributeEncryptionKey {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 500)]
		[string]$cipher,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNull()]
		[securestring]$secretKey,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$ldifzKey
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'attribute_encryption/update_key'

		$Request = $PSBoundParameters | Get-Parameter -ParametersToRemove secretKey
		$Request['secretKey'] = $secretKey | ConvertTo-InsecureString

		$Body = $Request | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, "Rotate Attribute Encryption Key ($cipher)")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
