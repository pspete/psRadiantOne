# .ExternalHelp psRadiantOne-help.xml
function Add-R1TruststoreCertificate {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
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
		[ValidateScript({
				if (-not (Test-Path -Path $PSItem -PathType Leaf)) {
					throw "Certificate file not found: $PSItem"
				}
				$true
			})]
		[string]$Path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'client_certificate_truststore'

		$Form = ConvertTo-MultipartFormData -Field @{
			'file'  = Get-Item -Path $Path
			'alias' = $alias
		}

		if ($PSCmdlet.ShouldProcess($alias, 'Import Truststore Certificate')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

		}

	}#process

	End { }#end

}
