function Set-R1WebSessionToken {
	<#
	.SYNOPSIS
	Sets the Authorization header of the module scope WebSession to the current bearer token.

	.DESCRIPTION
	The WebSession of the module scope session is there for a caller who wants to send their own
	requests with Invoke-WebRequest, so it must carry the token the module is currently using.

	A WebSession keeps the Authorization header of whichever request created it, which for the
	login request is the Basic credential. This replaces that header, and is called again whenever
	the token is renewed so that the WebSession never carries a token the module has stopped using.

	Does nothing when there is no WebSession or no token.

	.EXAMPLE
	Set-R1WebSessionToken

	Sets the WebSession Authorization header to the session token.
	#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Alters a property of the in-memory session object only; nothing is sent, and the caller has already confirmed the action which renewed the token')]
	[CmdletBinding()]
	[OutputType([void])]
	param( )

	Process {

		if (($null -ne $Script:psRadiantOneSession.WebSession) -and
			(-not ([string]::IsNullOrEmpty($Script:psRadiantOneSession.Token)))) {

			$Script:psRadiantOneSession.WebSession.Headers['Authorization'] = "Bearer $($Script:psRadiantOneSession.Token)"

		}

	}

}
