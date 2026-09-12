# .ExternalHelp psRadiantOne-help.xml
function Update-R1AuthToken {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
	[OutputType([void])]
	param( )

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'authToken/refresh'

		if (-not ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Refresh Authentication Token'))) {

			return

		}

		$Result = Invoke-R1RestMethod -Uri $URI -Method PUT

		if ($null -ne $Result.token) {

			$Claims = Get-R1TokenClaim -Token $Result.token

			$Script:psRadiantOneSession.Token = $Result.token
			$Script:psRadiantOneSession.TokenExpiry = $Claims.Expiry
			$Script:psRadiantOneSession.Privileges = $Claims.Privileges

		}

	}#process

	End { }#end

}
