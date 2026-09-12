# .ExternalHelp psRadiantOne-help.xml
function Get-R1TruststoreCertificate {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.CertificateDetails')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Alias'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$alias
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'client_certificate_truststore'

		if ($PSCmdlet.ParameterSetName -eq 'Alias') {

			$Path = "$Path/$($alias | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.CertificateDetails

		}

	}#process

	End { }#end

}
