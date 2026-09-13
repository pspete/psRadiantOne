# .ExternalHelp psRadiantOne-help.xml
function Import-R1DirectoryLdif {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Local')]
	[OutputType('psRadiantOne.LaunchedTask')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Local'
		)]
		[ValidateScript({
				if (-not (Test-Path -Path $PSItem -PathType Leaf)) {

					throw "File not found: $PSItem"

				}
				$true
			})]
		[Alias('FullName')]
		[string]$Path,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Server'
		)]
		[ValidateLength(1, 1000)]
		[string]$filename,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$overwrite
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Local') {

			$URI = Resolve-R1ServiceUrl -Service Browser -Path 'directory_browser/ldif/import_ldif/local'

			$UploadFile = Get-Item -Path $Path

			$Field = @{ file = $UploadFile }

			if ($PSBoundParameters.ContainsKey('overwrite')) {

				#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
				$Field['overwrite'] = "$overwrite".ToLowerInvariant()

			}

			$Form = ConvertTo-MultipartFormData -Field $Field

			$Body = $Form.Body
			$ContentType = $Form.ContentType
			$Target = $UploadFile.Name

		} else {

			$URI = Resolve-R1ServiceUrl -Service Browser -Path 'directory_browser/ldif/import_ldif/server'

			$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody
			$ContentType = 'application/json'
			$Target = $filename

		}

		if ($PSCmdlet.ShouldProcess($Target, 'Import LDIF')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body -ContentType $ContentType

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.LaunchedTask

			}

		}

	}#process

	End { }#end

}
