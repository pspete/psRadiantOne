# .ExternalHelp psRadiantOne-help.xml
function Import-R1DataSourceType {
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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'meta/import'

		$UploadFile = Get-Item -Path $Path

		$Form = ConvertTo-MultipartFormData -Field @{ file = $UploadFile }

		if ($PSCmdlet.ShouldProcess($UploadFile.Name, 'Upload Data Source Type Templates')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.TemplateImport

			}

		}

	}#process

	End { }#end

}
