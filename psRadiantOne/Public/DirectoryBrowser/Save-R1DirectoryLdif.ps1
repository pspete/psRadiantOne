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
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateScript({
				if (-not (Test-Path -Path $PSItem -PathType Container)) {

					throw "Directory not found: $PSItem"

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

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$OutputFile = Join-Path -Path $Path -ChildPath $fileName

			if ($Result -is [byte[]]) {

				[System.IO.File]::WriteAllBytes($OutputFile, $Result)

			} else {

				[System.IO.File]::WriteAllText($OutputFile, $Result)

			}

			Get-Item -Path $OutputFile

		}

	}#process

	End { }#end

}
