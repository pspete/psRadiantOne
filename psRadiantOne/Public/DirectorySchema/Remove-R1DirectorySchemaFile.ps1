# .ExternalHelp psRadiantOne-help.xml
function Remove-R1DirectorySchemaFile {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidatePattern('^[\w,\s-]+\.(?i)(ldif|ldifz)$')]
		[string]$fileName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Schema -Path "files/$($fileName | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($fileName, 'Delete Directory Schema File')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
