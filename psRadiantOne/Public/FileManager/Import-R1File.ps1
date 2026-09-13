# .ExternalHelp psRadiantOne-help.xml
function Import-R1File {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$filePath,

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

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'file_manager/files/upload'

		$UploadFile = Get-Item -Path $Path

		$Form = ConvertTo-MultipartFormData -Field @{
			filePath = $filePath
			file     = $UploadFile
		}

		if ($PSCmdlet.ShouldProcess($filePath, "Upload $($UploadFile.Name)")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

		}

	}#process

	End { }#end

}
