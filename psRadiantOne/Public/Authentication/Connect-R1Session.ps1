# .ExternalHelp psRadiantOne-help.xml
function Connect-R1Session {
	[CmdletBinding()]
	[OutputType('psRadiantOne.PasswordResetInfo')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$BaseURI,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[PSCredential]$Credential,

		[parameter(Mandatory = $false)]
		[switch]$SkipCertificateCheck
	)

	Begin { }#begin

	Process {

		#Reset any existing session so a stale token is not sent with the login request
		$Script:psRadiantOneSession.Token = $null
		$Script:psRadiantOneSession.TokenExpiry = $null
		$Script:psRadiantOneSession.Privileges = $null
		$Script:psRadiantOneSession.Organization = $null
		$Script:psRadiantOneSession.WebSession = $null
		$Script:psRadiantOneSession.BaseURI = $BaseURI -replace '/$', ''

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'v2/login'

		try {

			$Plaintext = "$($Credential.UserName):$($Credential.Password | ConvertTo-InsecureString)"
			$BasicAuth = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Plaintext))

		} finally {

			$Plaintext = $null

		}

		#SessionVariable makes the WebSession of the login request available in the module scope
		#session, for a caller who wants to send their own requests with Invoke-WebRequest.
		$RequestParameters = @{
			URI             = $URI
			Method          = 'POST'
			Headers         = @{ Authorization = "Basic $BasicAuth" }
			SessionVariable = 'R1WebSession'
		}

		if ($SkipCertificateCheck) {

			$RequestParameters.Add('SkipCertificateCheck', $true)

		}

		try {

			$Result = Invoke-R1RestMethod @RequestParameters

		} catch {

			#Leave no partial session behind if the login attempt failed
			$Script:psRadiantOneSession.BaseURI = $null
			$Script:psRadiantOneSession.WebSession = $null

			#Name the url which was called; a base url pointing at the control panel ui rather than
			#the api endpoint is otherwise indistinguishable from a credential problem
			$PSCmdlet.ThrowTerminatingError(

				[System.Management.Automation.ErrorRecord]::new(

					[System.Exception]::new("Login to $URI failed. $($PSItem.Exception.Message)", $PSItem.Exception),
					'psRadiantOne.LoginFailed',
					[System.Management.Automation.ErrorCategory]::AuthenticationError,
					$URI

				)

			)

		} finally {

			$BasicAuth = $null
			$RequestParameters['Headers'] = $null

			#A WebSession keeps the Authorization header of the request which created it, and this
			#one authenticated with Basic. Drop it, so the session does not hold the credential;
			#the bearer token replaces it below once the login is known to have succeeded.
			if ($null -ne $Script:psRadiantOneSession.WebSession) {

				$null = $Script:psRadiantOneSession.WebSession.Headers.Remove('Authorization')

			}

		}

		if ($Result.authenticated -eq $true) {

			$Claims = Get-R1TokenClaim -Token $Result.token

			$Script:psRadiantOneSession.Token = $Result.token
			$Script:psRadiantOneSession.User = $Claims.Username
			$Script:psRadiantOneSession.TokenExpiry = $Claims.Expiry
			$Script:psRadiantOneSession.Privileges = $Claims.Privileges
			$Script:psRadiantOneSession.Organization = $Claims.Organization
			$Script:psRadiantOneSession.StartTime = Get-Date

			Set-R1WebSessionToken

		} else {

			#An expired password is reported as a successful request with authenticated=false.
			#Return the reset information so that Reset-R1Password can be driven from it.
			if ($Result.passwordReset.allowed -eq $true) {

				Write-Warning 'The password for this account has expired. Reset it with Reset-R1Password, using the resetToken returned by this command.'

			} else {

				Write-Warning 'The password for this account has expired, and the applicable password policy does not permit the user to change it. Contact an administrator.'

			}

			$Result.passwordReset | Add-CustomType -Type psRadiantOne.PasswordResetInfo

		}

	}#process

	End { }#end

}
