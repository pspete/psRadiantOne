function Save-R1Download {
	<#
	.SYNOPSIS
	Downloads a file from the RadiantOne API and saves it locally.

	.DESCRIPTION
	The response is written straight to disk, so a binary download arrives intact.

	A path naming an existing directory is where the file is saved, under the name given in the
	Content-Disposition header of the response. Any other path is the full path of the file, and the
	name it ends in is used whatever the response gives. Without a path, the file is saved to the
	current user's Downloads directory.

	The name the response gives cannot be known until the response arrives, so the download is
	written to a temporary file in the destination directory first, then renamed.

	.PARAMETER Uri
	The address of the download.

	.PARAMETER Method
	The method of the request.

	.PARAMETER Body
	The body of the request, where the download requires one.

	.PARAMETER Path
	The directory to save the file into, or the full path of the file.

	.PARAMETER DefaultName
	The name to save the file under when neither the path nor the response gives one.

	.EXAMPLE
	Save-R1Download -Uri $URI -Method GET -Path 'C:\Exports' -DefaultName 'datasources.zip'

	Saves the download into C:\Exports, named as the response names it.

	.OUTPUTS
	System.IO.FileInfo
	#>
	[CmdletBinding()]
	[OutputType([System.IO.FileInfo])]
	param(
		[parameter(Mandatory = $true)]
		[string]$Uri,

		[parameter(Mandatory = $true)]
		[ValidateSet('GET', 'POST')]
		[string]$Method,

		[parameter(Mandatory = $false)]
		[object]$Body,

		[parameter(Mandatory = $false)]
		[string]$Path,

		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$DefaultName
	)

	$FileName = $null

	if (-not ($PSBoundParameters.ContainsKey('Path'))) {

		$Directory = Get-R1DownloadPath

	} elseif (Test-Path -LiteralPath $Path -PathType Container) {

		$Directory = $Path

	} else {

		$Directory = Split-Path -Path $Path -Parent
		$FileName = Split-Path -Path $Path -Leaf

		#A bare file name is saved to the current location
		if ([string]::IsNullOrEmpty($Directory)) {

			$Directory = '.'

		}

	}

	if (-not (Test-Path -LiteralPath $Directory -PathType Container)) {

		$PSCmdlet.ThrowTerminatingError(

			[System.Management.Automation.ErrorRecord]::new(

				[System.IO.DirectoryNotFoundException]::new("Directory not found: $Directory"),
				'psRadiantOne.DirectoryNotFound',
				[System.Management.Automation.ErrorCategory]::ObjectNotFound,
				$Directory

			)

		)

	}

	$Directory = (Resolve-Path -LiteralPath $Directory).ProviderPath

	$TempFile = Join-Path -Path $Directory -ChildPath ([System.IO.Path]::GetRandomFileName())

	$Request = @{
		Uri     = $Uri
		Method  = $Method
		OutFile = $TempFile
	}

	if ($PSBoundParameters.ContainsKey('Body')) {

		$Request['Body'] = $Body

	}

	try {

		$Response = Invoke-R1RestMethod @Request

		if ([string]::IsNullOrEmpty($FileName)) {

			$FileName = Get-R1DownloadFileName -Response $Response

		}

		if ([string]::IsNullOrEmpty($FileName)) {

			$FileName = $DefaultName

		}

		$OutputFile = Join-Path -Path $Directory -ChildPath $FileName

		Move-Item -LiteralPath $TempFile -Destination $OutputFile -Force

		Get-Item -LiteralPath $OutputFile

	} finally {

		#Left behind only when the download or the rename failed
		if (Test-Path -LiteralPath $TempFile) {

			Remove-Item -LiteralPath $TempFile -Force

		}

	}

}
