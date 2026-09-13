# .ExternalHelp psRadiantOne-help.xml
function New-R1FileManagerDirectory {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$path,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$folderName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'file_manager/directories'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess("$path/$folderName", 'Create Directory')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
