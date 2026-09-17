function Get-R1DownloadFileName {
	<#
	.SYNOPSIS
	Returns the file name a download was sent with.

	.DESCRIPTION
	Reads the name from the Content-Disposition header of the response. The extended filename*
	form, which carries an encoded name, is preferred over the plain filename form when a response
	gives both.

	A name taken from a response is used only as a file name and never as a path, so anything before
	its last path separator is discarded. Nothing is returned when the response gives no name, or
	gives one which cannot name a file.

	.PARAMETER Response
	The web response of the download.

	.EXAMPLE
	Get-R1DownloadFileName -Response $Response

	Returns radiantone-datasources-export.zip for a response carrying
	Content-Disposition: attachment; filename=radiantone-datasources-export.zip

	.OUTPUTS
	System.String
	#>
	[CmdletBinding()]
	[OutputType([string])]
	param(
		[parameter(Mandatory = $true)]
		[AllowNull()]
		[object]$Response
	)

	if ($null -eq $Response.Headers) {

		return

	}

	#Header names are case insensitive, and PowerShell 7 holds each value as a collection
	$Disposition = foreach ($Key in @($Response.Headers.Keys)) {

		if ($Key -eq 'Content-Disposition') {

			@($Response.Headers[$Key])[0]

		}

	}

	$Disposition = @($Disposition)[0]

	if ([string]::IsNullOrEmpty($Disposition)) {

		return

	}

	$Name = $null

	if ($Disposition -match "filename\*\s*=\s*[^']*'[^']*'(?<name>[^;]+)") {

		$Name = [System.Uri]::UnescapeDataString($Matches['name'].Trim())

	} elseif ($Disposition -match 'filename\s*=\s*"(?<name>[^"]+)"') {

		$Name = $Matches['name']

	} elseif ($Disposition -match 'filename\s*=\s*(?<name>[^;]+)') {

		$Name = $Matches['name'].Trim()

	}

	$Name = ("$Name" -split '[\\/]')[-1]

	if ([string]::IsNullOrWhiteSpace($Name) -or ($Name -in '.', '..') -or ($Name.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars()) -ge 0)) {

		return

	}

	$Name

}
