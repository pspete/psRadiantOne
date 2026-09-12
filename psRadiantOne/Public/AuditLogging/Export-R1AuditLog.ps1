# .ExternalHelp psRadiantOne-help.xml
function Export-R1AuditLog {
	[CmdletBinding()]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$OutFile
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'audit_logs/download'

		#The logs are returned as a binary stream, so they are written straight to the file
		$null = Invoke-R1RestMethod -Uri $URI -Method GET -OutFile $OutFile

	}#process

	End { }#end

}
