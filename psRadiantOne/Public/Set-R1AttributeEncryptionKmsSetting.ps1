# .ExternalHelp psRadiantOne-help.xml
function Set-R1AttributeEncryptionKmsSetting {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[securestring]$accessKeyId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[securestring]$accessKeySecret,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 5000)]
		[string]$cmkRegion,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 5000)]
		[string]$cmkAlias,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[switch]$useExistingCredentials
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'attribute_encryption/aws_kms'

		if ($useExistingCredentials) {

			$Path = "$Path`?useExistingCredentials=true"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		#The retrieval reports only whether the credentials exist, not their values, so only the
		#region and alias can be carried forward. Specify useExistingCredentials to keep the stored
		#credentials, in which case any secret in the body is ignored by the API.
		$Existing = Get-R1AttributeEncryptionKmsSetting

		$Template = [ordered]@{
			cmkRegion = $null
			cmkAlias  = $null
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove accessKeyId, accessKeySecret, useExistingCredentials) -Fallback $Existing

		if ($PSBoundParameters.ContainsKey('accessKeyId')) {

			$Request['accessKeyId'] = $accessKeyId | ConvertTo-InsecureString

		}

		if ($PSBoundParameters.ContainsKey('accessKeySecret')) {

			$Request['accessKeySecret'] = $accessKeySecret | ConvertTo-InsecureString

		}

		$Body = $Request | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update AWS KMS Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
