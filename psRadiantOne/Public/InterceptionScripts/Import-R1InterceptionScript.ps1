# .ExternalHelp psRadiantOne-help.xml
function Import-R1InterceptionScript {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
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
		[string]$Path,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isOverwrite
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$RequestPath = 'interception_scripts'

		$Query = $PSBoundParameters | Get-Parameter -ParametersToRemove Path

		if ($Query.ContainsKey('isOverwrite')) {

			#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
			$Query['isOverwrite'] = "$($Query['isOverwrite'])".ToLowerInvariant()

			$RequestPath = "$RequestPath?$($Query | ConvertTo-QueryString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path $RequestPath

		$File = Get-Item -Path $Path

		$Form = ConvertTo-MultipartFormData -Field @{ file = $File }

		if ($PSCmdlet.ShouldProcess($File.Name, 'Upload Interception Script')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

		}

	}#process

	End { }#end

}
