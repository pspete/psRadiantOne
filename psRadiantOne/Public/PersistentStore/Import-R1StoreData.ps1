# .ExternalHelp psRadiantOne-help.xml
function Import-R1StoreData {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType('psRadiantOne.LaunchedTask')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateScript( { Test-Path -Path $_ -PathType Leaf })]
		[Alias('FullName')]
		[string]$Path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/store/initialize/upload"

		$UploadFile = Get-Item -Path $Path

		$Form = ConvertTo-MultipartFormData -Field @{
			file = $UploadFile
		}

		if ($PSCmdlet.ShouldProcess($dn, "Initialize Directory Store from $($UploadFile.Name)")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.LaunchedTask

			}

		}

	}#process

	End { }#end

}
