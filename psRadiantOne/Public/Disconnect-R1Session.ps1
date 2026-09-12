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

			$TokenExpiry = $Script:psRadiantOneSession.TokenExpiry

			try {

				$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

			} catch {

				#Revoking a token requires SCOPE_AUTH_TOKEN_REVOKE, granted by a role holding
				#revokeTokenPermission. Without it the token stays valid until it expires. The local
				#session is cleared regardless, so no later command keeps using a session the caller
				#has asked to close.
				Write-Warning "The authentication token could not be revoked and remains valid until $TokenExpiry. The local session has been cleared. $($PSItem.Exception.Message)"

			}

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
