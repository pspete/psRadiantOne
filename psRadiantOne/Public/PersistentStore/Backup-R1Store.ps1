# .ExternalHelp psRadiantOne-help.xml
function Backup-R1Store {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/store/backup"

		if ($PSCmdlet.ShouldProcess($dn, 'Back Up Directory Store')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
