function ConvertTo-R1SessionResult {
	<#
	.SYNOPSIS
	Shapes an API response for the LastCommandResults property of the session object.

	.DESCRIPTION
	The session object records the result of the last command so that a caller can see what the
	API answered without repeating the request. Responses carry secrets as well as requests do:
	the login and token refresh responses are a bearer token, and the password reset information
	of an expired account carries a reset token.

	Returns the status, headers and content of the response, with any secret value in the content
	replaced by Hide-SecretValue. Content which is not text, such as a file download, is not kept.

	.PARAMETER Response
	The response to shape. A null response returns nothing.

	.PARAMETER SecretResponse
	The content of this response is itself a secret, and is withheld rather than sanitised.

	Hide-SecretValue matches a named JSON property, so it cannot mask a response whose whole body
	is the secret. The endpoint which creates an access token answers that way.

	.EXAMPLE
	ConvertTo-R1SessionResult -Response $APIResponse

	Returns the response with any secret value in its content masked.

	.EXAMPLE
	ConvertTo-R1SessionResult -Response $APIResponse -SecretResponse

	Returns the response with its content withheld.

	.OUTPUTS
	psRadiantOne.CommandResult
	#>
	[CmdletBinding()]
	[OutputType('psRadiantOne.CommandResult')]
	param(
		[parameter(
			Mandatory = $false,
			Position = 0
		)]
		[AllowNull()]
		[object]$Response,

		[parameter(Mandatory = $false)]
		[switch]$SecretResponse
	)

	Process {

		if ($null -eq $Response) {

			return

		}

		$RawContent = $Response.Content

		$Content = if ($SecretResponse) {

			'******'

		} elseif (($RawContent -is [string]) -and (-not ([string]::IsNullOrEmpty($RawContent)))) {

			Hide-SecretValue -InputValue $RawContent

		} else {

			$null

		}

		[pscustomobject]@{
			StatusCode        = $Response.StatusCode
			StatusDescription = $Response.StatusDescription
			Headers           = $Response.Headers
			Content           = $Content
		} | Add-CustomType -Type psRadiantOne.CommandResult

	}

}
