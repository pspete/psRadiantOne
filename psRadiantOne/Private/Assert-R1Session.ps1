function Assert-R1Session {
	<#
	.SYNOPSIS
	Ensures an authenticated RadiantOne session is present.

	.DESCRIPTION
	Checks the module scope session for the values a request requires, and throws when they are
	absent, naming the command to run. The error stops the calling command, so no request is sent.

	Without this check a command issued before Connect-R1Session fails against a null base URL,
	reporting a URI format error rather than the missing session.

	.PARAMETER RequireToken
	Also require an authentication token to be present in the session. Specify for any command
	other than those which establish the session.

	.EXAMPLE
	Assert-R1Session

	Throws if no BaseURI is held in the module scope session.

	.EXAMPLE
	Assert-R1Session -RequireToken

	Throws if no BaseURI or authentication token is held in the module scope session.
	#>
	[CmdletBinding()]
	[OutputType([void])]
	param(
		[parameter(Mandatory = $false)]
		[switch]$RequireToken
	)

	Process {

		if ([string]::IsNullOrEmpty($Script:psRadiantOneSession.BaseURI)) {

			#thrown rather than reported with ThrowTerminatingError, which would end this check alone
			#and leave the calling command to carry on and send its request
			throw [System.Management.Automation.ErrorRecord]::new(

				[System.Exception]::new('No RadiantOne session found. Run Connect-R1Session first.'),
				'psRadiantOne.NoSession',
				[System.Management.Automation.ErrorCategory]::ConnectionError,
				$Script:psRadiantOneSession

			)

		}

		if (($RequireToken) -and ([string]::IsNullOrEmpty($Script:psRadiantOneSession.Token))) {

			#thrown rather than reported with ThrowTerminatingError, which would end this check alone
			#and leave the calling command to carry on and send its request
			throw [System.Management.Automation.ErrorRecord]::new(

				[System.Exception]::new('No RadiantOne authentication token found. Run Connect-R1Session first.'),
				'psRadiantOne.NoToken',
				[System.Management.Automation.ErrorCategory]::AuthenticationError,
				$Script:psRadiantOneSession

			)

		}

	}

}
