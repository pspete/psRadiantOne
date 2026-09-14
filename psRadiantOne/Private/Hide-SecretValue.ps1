Function Hide-SecretValue {
	<#
	.SYNOPSIS
	Hide a secret value by converting it to "******"

	.DESCRIPTION
	Matches a pattern in a JSON formatted string which is expected to contain a secret value.
	Replaces all secret values with "******", and returns a sanitised string.
	Enables a request body to be included in debug/verbose streams without exposing secret values.

	.PARAMETER InputValue
	JSON body of API request

	.PARAMETER SecretsToRemove
	Any additional JSON properties which should be sanitised.

	.PARAMETER Secrets
	Default JSON properties known to contain secrets in the RadiantOne API.

	.EXAMPLE
	Hide-SecretValue -InputValue $String

	Returns $String with the value of any known secret property replaced with "******"
	#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Position = 0,
			Mandatory = $true,
			ValueFromPipeline = $true)]
		[String]$InputValue,

		[parameter(
			Mandatory = $false)]
		[array]$SecretsToRemove = @(),

		[parameter(
			Mandatory = $false)]
		[array]$Secrets = @(
			'password',
			'newPassword',
			'oldPassword',
			'currentPassword',
			'bindReqPassword',
			'clientSecret',
			'secretKey',
			'accessKeySecret',

			#Returned by the API rather than sent to it: the login and token refresh responses, and
			#the password reset information of an expired account
			'token',
			'resetToken',
			'refreshToken'
		)
	)

	BEGIN { }#begin

	PROCESS {

		$OutputValue = $InputValue

		#Combine base properties and any additional properties to remove
		($SecretsToRemove + $Secrets) |

			ForEach-Object {

				#Match the property's own quoted value only - an escaped quote within the value does
				#not end the match, and the match cannot run past it into a following property, so
				#compressed (single line) and indented JSON are both handled
				$Pattern = '("{0}"\s*:\s*)"(?:\\.|[^"\\])*"' -f [regex]::Escape($PSItem)

				$OutputValue = $OutputValue -replace $Pattern, '$1"******"'

			}

	}#process

	END {

		#Return Output
		$OutputValue

	}#end

}
