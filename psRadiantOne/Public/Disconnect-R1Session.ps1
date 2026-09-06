# .ExternalHelp psRadiantOne-help.xml
function Disconnect-R1Session {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path "authToken/$($Script:psRadiantOneSession.Token | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Revoke Authentication Token')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

			$Script:psRadiantOneSession.BaseURI = $null
			$Script:psRadiantOneSession.User = $null
			$Script:psRadiantOneSession.Token = $null
			$Script:psRadiantOneSession.TokenExpiry = $null
			$Script:psRadiantOneSession.Privileges = $null
			$Script:psRadiantOneSession.Organization = $null
			$Script:psRadiantOneSession.Version = $null
			$Script:psRadiantOneSession.WebSession = $null
			$Script:psRadiantOneSession.StartTime = $null
			$Script:psRadiantOneSession.ElapsedTime = $null

		}

	}#process

	End { }#end

}
