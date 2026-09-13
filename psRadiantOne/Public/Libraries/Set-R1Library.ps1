# .ExternalHelp psRadiantOne-help.xml
function Set-R1Library {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.Library')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$groupId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$artifactId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$version,

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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "libraries/$($groupId | Get-EscapedString)/$($artifactId | Get-EscapedString)/$($version | Get-EscapedString)"

		$UploadFile = Get-Item -Path $Path

		$Form = ConvertTo-MultipartFormData -Field @{ file = $UploadFile }

		if ($PSCmdlet.ShouldProcess("$groupId`:$artifactId`:$version", 'Replace Library')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Form.Body -ContentType $Form.ContentType

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.Library

			}

		}

	}#process

	End { }#end

}
