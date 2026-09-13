# .ExternalHelp psRadiantOne-help.xml
function Import-R1PrivateFile {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$meta,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$property,

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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "private_files/$($name | Get-EscapedString)/upload/$($meta | Get-EscapedString)/$($property | Get-EscapedString)"

		$UploadFile = Get-Item -Path $Path

		$Form = ConvertTo-MultipartFormData -Field @{ file = $UploadFile }

		if ($PSCmdlet.ShouldProcess($name, "Upload Private File $($UploadFile.Name)")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

		}

	}#process

	End { }#end

}
