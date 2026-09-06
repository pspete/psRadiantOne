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

		$RequestParameters = @{
			URI     = $URI
			Method  = 'POST'
			Headers = @{ Authorization = "Basic $BasicAuth" }
		}

		if ($SkipCertificateCheck) {

			$RequestParameters.Add('SkipCertificateCheck', $true)

		}

		try {

			$Result = Invoke-R1RestMethod @RequestParameters

		} catch {

			#Leave no partial session behind if the login attempt failed
			$Script:psRadiantOneSession.BaseURI = $null
			throw $PSItem

		} finally {

			$BasicAuth = $null
			$RequestParameters['Headers'] = $null

		}

		if ($Result.authenticated -eq $true) {

			$Claims = Get-R1TokenClaim -Token $Result.token

			$Script:psRadiantOneSession.Token = $Result.token
			$Script:psRadiantOneSession.User = $Claims.Username
			$Script:psRadiantOneSession.TokenExpiry = $Claims.Expiry
			$Script:psRadiantOneSession.Privileges = $Claims.Privileges
			$Script:psRadiantOneSession.Organization = $Claims.Organization
			$Script:psRadiantOneSession.StartTime = Get-Date

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
