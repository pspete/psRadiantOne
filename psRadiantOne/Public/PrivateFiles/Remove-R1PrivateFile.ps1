# .ExternalHelp psRadiantOne-help.xml
function Remove-R1PrivateFile {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$filename
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "private_files/$($name | Get-EscapedString)/delete/$($filename | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($name, "Delete Private File $filename")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
