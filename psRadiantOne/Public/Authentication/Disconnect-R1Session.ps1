# .ExternalHelp psRadiantOne-help.xml
function Disconnect-R1Session {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	param(
		[parameter(Mandatory = $false)]
		[switch]$Force
	)

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
				#revokeTokenPermission. A token which was not revoked is still valid, so by default
				#the session is left intact: reporting it as closed would be untrue, and discarding
				#the token would remove any means of retrying the revocation.
				if (-not $Force) {

					throw $PSItem

				}

				Write-Warning "The authentication token could not be revoked and remains valid until $TokenExpiry. The local session has been cleared as -Force was specified. $($PSItem.Exception.Message)"

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
