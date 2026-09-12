# .ExternalHelp psRadiantOne-help.xml
function Get-R1AttributeEncryptionKmsSetting {
	[CmdletBinding()]
	[OutputType('psRadiantOne.AwsKmsSettings')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'attribute_encryption/aws_kms'

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.AwsKmsSettings

		}

	}#process

	End { }#end

}
