function Get-R1DownloadPath {
	<#
	.SYNOPSIS
	Returns the directory a downloaded file is saved to when no path is given.

	.DESCRIPTION
	On Windows, Downloads is a known folder which a user or a policy can move, for example into a
	OneDrive folder, so its location is read from the user's shell folder settings rather than
	assumed.

	Where that setting cannot be read, or on another platform, the Downloads directory under the
	user's home directory is returned.

	.EXAMPLE
	Get-R1DownloadPath

	Returns the current user's Downloads directory.

	.OUTPUTS
	System.String
	#>
	[CmdletBinding()]
	[OutputType([string])]
	param()

	$DownloadPath = $null

	if ([System.Environment]::OSVersion.Platform -eq 'Win32NT') {

		$ShellFolders = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
		$Downloads = '{374DE290-123F-4565-9164-39C4925E467B}'

		$Folder = Get-ItemProperty -Path $ShellFolders -Name $Downloads -ErrorAction SilentlyContinue

		if ($null -ne $Folder) {

			#The setting holds unexpanded variables, such as %USERPROFILE%\Downloads
			$DownloadPath = [System.Environment]::ExpandEnvironmentVariables($Folder.$Downloads)

		}

	}

	if ([string]::IsNullOrEmpty($DownloadPath)) {

		$DownloadPath = Join-Path -Path $HOME -ChildPath 'Downloads'

	}

	$DownloadPath

}
