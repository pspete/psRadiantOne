function Get-R1TokenClaim {
	<#
	.SYNOPSIS
	Decodes the claims held in a RadiantOne authentication token.

	.DESCRIPTION
	The token returned by the RadiantOne login endpoints is a JWT, whose payload carries the
	details of the authenticated session: the bind dn of the user, the token expiry, the granted
	privileges, and the organization and server the token was issued for.

	Decodes the payload segment and returns those claims, for use in populating the module scope
	session. The token signature is not verified; validation is performed by the API.

	.PARAMETER Token
	The JWT returned by the RadiantOne login or token refresh endpoint.

	.EXAMPLE
	Get-R1TokenClaim -Token $Token

	Returns the claims held in $Token.

	.OUTPUTS
	PSCustomObject with Username, Expiry, Privileges, Organization and Server properties.
	#>
	[CmdletBinding()]
	[OutputType('System.Management.Automation.PSObject')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			Position = 0
		)]
		[string]$Token
	)

	Process {

		$Payload = ($Token -split '\.')[1]

		if ([string]::IsNullOrEmpty($Payload)) {

			return

		}

		#Restore the padding removed by base64url encoding, and translate to standard base64
		$Padded = $Payload.Replace('-', '+').Replace('_', '/')
		$Padded = $Padded.PadRight($Padded.Length + ((4 - ($Padded.Length % 4)) % 4), '=')

		try {

			$Claims = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Padded)) |
				ConvertFrom-Json -ErrorAction Stop

		} catch {

			Write-Debug "[Token] Claims could not be decoded: $($PSItem.Exception.Message)"
			return

		}

		$Expiry = $null

		if ($null -ne $Claims.exp) {

			$Expiry = [System.DateTimeOffset]::FromUnixTimeSeconds($Claims.exp).LocalDateTime

		}

		[PSCustomObject]@{
			Username     = $Claims.username
			Expiry       = $Expiry
			Privileges   = $Claims.privileges
			Organization = $Claims.organization
			Server       = $Claims.server
		}

	}

}
