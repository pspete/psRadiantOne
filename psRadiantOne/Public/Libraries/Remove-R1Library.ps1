# .ExternalHelp psRadiantOne-help.xml
function Remove-R1Library {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$groupId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$artifactId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$version
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "libraries/$($groupId | Get-EscapedString)/$($artifactId | Get-EscapedString)/$($version | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess("$groupId`:$artifactId`:$version", 'Remove Library')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
