# .ExternalHelp psRadiantOne-help.xml
function Remove-R1File {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('file')]
		[string[]]$filePaths
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'file_manager/files/bulk-delete'

		$Body = @{ filePaths = @($filePaths) } | ConvertTo-R1JsonBody -EmptyArrayProperty filePaths

		if ($PSCmdlet.ShouldProcess(($filePaths -join ', '), "Delete Files ($($filePaths.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
