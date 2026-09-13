# .ExternalHelp psRadiantOne-help.xml
function Remove-R1DirectoryEntry {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$deleteSubNodes
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "directory_browser/$($dn | Get-EscapedString)"

		if ($PSBoundParameters.ContainsKey('deleteSubNodes')) {

			#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
			$Path = "$Path`?deleteSubNodes=$("$deleteSubNodes".ToLowerInvariant())"

		}

		$URI = Resolve-R1ServiceUrl -Service Browser -Path $Path

		if ($PSCmdlet.ShouldProcess($dn, 'Delete Directory Entry')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
