# .ExternalHelp psRadiantOne-help.xml
function Set-R1AttributeEncryption {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$encryptKeyInUse,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$currentHdapCipher,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$currentLdifzCipher,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$secureLdifExport
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'attribute_encryption'

		#Retrieve the current settings and send them back with the supplied values applied over them,
		#so a setting left unspecified keeps its current value.
		$Existing = Get-R1AttributeEncryption

		#hdapAttrKeyExists, ldifzKeyExists and availableCiphers report state the API maintains, so
		#they are not sent back.
		$Template = [ordered]@{
			encryptKeyInUse    = $false
			currentHdapCipher  = $null
			currentLdifzCipher = $null
			secureLdifExport   = $false
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Attribute Encryption Settings')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
