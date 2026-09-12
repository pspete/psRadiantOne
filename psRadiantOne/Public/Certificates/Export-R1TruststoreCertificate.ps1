# .ExternalHelp psRadiantOne-help.xml
function Export-R1TruststoreCertificate {
	[CmdletBinding()]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$alias,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$OutFile
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "client_certificate_truststore/$($alias | Get-EscapedString)/export"

		#The certificate is returned as a binary stream, so it is written straight to the file
		$null = Invoke-R1RestMethod -Uri $URI -Method GET -OutFile $OutFile

	}#process

	End { }#end

}
