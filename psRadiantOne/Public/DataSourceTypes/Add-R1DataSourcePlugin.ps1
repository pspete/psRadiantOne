# .ExternalHelp psRadiantOne-help.xml
function Add-R1DataSourcePlugin {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.TemplateImport')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateScript({
				if (-not (Test-Path -Path $PSItem -PathType Leaf)) {

					throw "File not found: $PSItem"

				}
				$true
			})]
		[Alias('FullName')]
		[string]$Path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'meta/plugins'

		$UploadFile = Get-Item -Path $Path

		$Form = ConvertTo-MultipartFormData -Field @{ file = $UploadFile }

		if ($PSCmdlet.ShouldProcess($UploadFile.Name, 'Import Plugin')) {

			#The upload stages the plugin rather than installing it, and the reply carries the id
			#which Complete-R1DataSourceTypeImport and Remove-R1DataSourceTypeImport act on.
			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.TemplateImport

			}

		}

	}#process

	End { }#end

}
