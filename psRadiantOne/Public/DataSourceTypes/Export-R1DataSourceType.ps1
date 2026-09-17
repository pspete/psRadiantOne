# .ExternalHelp psRadiantOne-help.xml
function Export-R1DataSourceType {
	[CmdletBinding()]
	[OutputType('System.IO.FileInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string[]]$templates,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateScript({
				#Either an existing directory, or the full path of a file in one
				$Directory = if (Test-Path -LiteralPath $PSItem -PathType Container) { $PSItem } else { Split-Path -Path $PSItem -Parent }

				if ((-not ([string]::IsNullOrEmpty($Directory))) -and (-not (Test-Path -LiteralPath $Directory -PathType Container))) {

					throw "Directory not found: $Directory"

				}
				$true
			})]
		[string]$Path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'meta/export'

		$Body = @{ templates = @($templates) } | ConvertTo-R1JsonBody

		$Download = @{
			Uri         = $URI
			Method      = 'POST'
			Body        = $Body
			DefaultName = 'templates.zip'
		}

		if ($PSBoundParameters.ContainsKey('Path')) {

			$Download['Path'] = $Path

		}

		Save-R1Download @Download

	}#process

	End { }#end

}
