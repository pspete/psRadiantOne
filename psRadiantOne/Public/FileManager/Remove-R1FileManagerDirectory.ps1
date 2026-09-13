# .ExternalHelp psRadiantOne-help.xml
function Remove-R1FileManagerDirectory {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ path = $path } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "file_manager/directories`?$Query"

		if ($PSCmdlet.ShouldProcess($path, 'Delete Directory')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
