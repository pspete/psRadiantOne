# .ExternalHelp psRadiantOne-help.xml
function Save-R1DirectoryLdif {
	[CmdletBinding()]
	[OutputType('System.IO.FileInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$sourceDn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('BASE', 'ONE', 'SUB')]
		[string]$scope,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidatePattern('^[\w,\s-]+\.(ldif|ldifz|LDIF|LDIFZ)$')]
		[string]$fileName,

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
		[string]$Path,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$targetDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, 100000)]
		[int]$maxEntries,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isExportForReplication
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Browser -Path 'directory_browser/ldif/download'

		$Body = $PSBoundParameters | Get-Parameter -ParametersToRemove Path | ConvertTo-R1JsonBody

		$Download = @{
			Uri         = $URI
			Method      = 'POST'
			Body        = $Body
			DefaultName = $fileName
		}

		if ($PSBoundParameters.ContainsKey('Path')) {

			$Download['Path'] = $Path

		}

		Save-R1Download @Download

	}#process

	End { }#end

}
