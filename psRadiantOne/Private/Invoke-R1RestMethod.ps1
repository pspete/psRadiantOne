function Invoke-R1RestMethod {
	<#
	.SYNOPSIS
	Wrapper for Invoke-WebRequest to call the RadiantOne API

	.DESCRIPTION
	Sends requests to the RadiantOne API, catches exceptions and outputs success.
	Acts as a wrapper for the Invoke-WebRequest cmdlet so that status codes can be queried and
	acted on, and so that every command in the module sends its request the same way.

	The authentication token held in the module scope session is sent as a bearer token, unless
	an Authorization header is supplied by the caller.
	Unless otherwise specified, requests are sent with ContentType=application/json.

	.PARAMETER Method
	The method for the REST Method.
	Only accepts GET, POST, PUT, PATCH or DELETE

	.PARAMETER URI
	The address of the API or service to send the request to.

	.PARAMETER Body
	The body of the request to send to the API

	.PARAMETER Headers
	The header of the request to send to the API.

	.PARAMETER SessionVariable
	If passed, will be sent to Invoke-WebRequest which in turn will create a websession variable
	using the string value as the name. This variable will only exist in the current scope, so
	will be set as the value of the module scope session WebSession property.
	Cannot be specified with WebSession

	.PARAMETER WebSession
	Accepts a WebRequestSession object containing session details
	Cannot be specified with SessionVariable

	.PARAMETER Credential
	See Invoke-WebRequest

	.PARAMETER TimeoutSec
	See Invoke-WebRequest
	Specify a timeout value in seconds

	.PARAMETER Certificate
	See Invoke-WebRequest
	The client certificate used for a secure web request.

	.PARAMETER CertificateThumbprint
	See Invoke-WebRequest
	The thumbprint of the certificate to use for client certificate authentication.

	.PARAMETER ContentType
	Specifies the content type of the web request.

	.PARAMETER OutFile
	Saves the response body to the specified file, for the endpoints which return a file download.

	.PARAMETER SkipCertificateCheck
	Bypass certificate validation for the request. Applies to deployments presenting a self-signed
	certificate.

	.EXAMPLE
	Invoke-R1RestMethod -Uri $URI -Method GET

	Send request to the RadiantOne API
	#>
	[CmdletBinding(DefaultParameterSetName = 'WebSession')]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateSet('GET', 'POST', 'PUT', 'DELETE', 'PATCH')]
		[String]$Method,

		[Parameter(Mandatory = $true)]
		[String]$URI,

		[Parameter(Mandatory = $false)]
		[Object]$Body,

		[Parameter(Mandatory = $false)]
		[hashtable]$Headers,

		[Parameter(
			Mandatory = $false,
			ParameterSetName = 'SessionVariable'
		)]
		[String]$SessionVariable,

		[Parameter(
			Mandatory = $false,
			ParameterSetName = 'WebSession'
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[Parameter(Mandatory = $false)]
		[PSCredential]$Credential,

		[Parameter(Mandatory = $false)]
		[int]$TimeoutSec,

		[Parameter(Mandatory = $false)]
		[System.Security.Cryptography.X509Certificates.X509Certificate]$Certificate,

		[Parameter(Mandatory = $false)]
		[string]$CertificateThumbprint,

		[Parameter(Mandatory = $false)]
		[string]$ContentType,

		[Parameter(Mandatory = $false)]
		[string]$OutFile,

		[Parameter(Mandatory = $false)]
		[switch]$SkipCertificateCheck
	)

	Begin {

		#Set defaults for all function calls
		$ProgressPreference = 'SilentlyContinue'
		$PSBoundParameters.Add('UseBasicParsing', $true)

		#Send the session token as a bearer token unless the caller supplied its own Authorization header
		if (-not ($PSBoundParameters.ContainsKey('Headers'))) {

			$PSBoundParameters.Add('Headers', @{ })

		}

		if ((-not ($PSBoundParameters['Headers'].ContainsKey('Authorization'))) -and
			(-not ([string]::IsNullOrEmpty($Script:psRadiantOneSession.Token)))) {

			$PSBoundParameters['Headers'].Add('Authorization', "Bearer $($Script:psRadiantOneSession.Token)")

		}

		if ($null -ne $Script:psRadiantOneSession.WebSession) {

			#use the WebSession if it exists in the module scope, and alternate session is not specified.
			if (-not ($PSBoundParameters.ContainsKey('WebSession'))) {

				$PSBoundParameters.Add('WebSession', $Script:psRadiantOneSession.WebSession)

			}

		}

		#Unless otherwise specified, expected content type is json
		if (-not ($PSBoundParameters.ContainsKey('ContentType'))) {

			$PSBoundParameters.Add('ContentType', 'application/json')

		}

		#Bypass strict RFC header parsing in PS Core
		if ($IsCoreCLR) {

			$PSBoundParameters.Add('SkipHeaderValidation', $true)

		} else {

			#SkipCertificateCheck is a PowerShell Core parameter; Windows PowerShell requires a callback
			$null = $PSBoundParameters.Remove('SkipCertificateCheck')

			if ($SkipCertificateCheck) {

				[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

			}

		}

		#If Tls12 Security Protocol is available
		if (([Net.SecurityProtocolType].GetEnumNames() -contains 'Tls12') -and

			#And Tls12 is not already in use
			(-not ([System.Net.ServicePointManager]::SecurityProtocol -match 'Tls12'))) {

			[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

		}

	}

	Process {

		#Show sanitised request body if in debug mode
		If ([System.Management.Automation.ActionPreference]::SilentlyContinue -ne $DebugPreference) {

			If (($PSBoundParameters.ContainsKey('Body')) -and ($null -ne $PSBoundParameters['Body'])) {

				switch (($Body).GetType().Name) {

					'String' { Write-Debug "[Body] $(Hide-SecretValue -InputValue $Body)" }

					'Byte[]' { Write-Debug "[Body] $(Hide-SecretValue -InputValue $([System.Text.Encoding]::UTF8.GetString($Body)))" }

				}

			}

		}

		#Send a String body as raw UTF8 bytes so ParameterBinding/module logging of the
		#Invoke-WebRequest call records a non-revealing type name (System.Byte[]) instead of the
		#literal request content
		if (($PSBoundParameters.ContainsKey('Body')) -and ($null -ne $PSBoundParameters['Body']) -and (($PSBoundParameters['Body']).GetType().Name -eq 'String')) {

			$PSBoundParameters['Body'] = [System.Text.Encoding]::UTF8.GetBytes($PSBoundParameters['Body'])

		}

		try {

			#make web request, splat PSBoundParameters
			$APIResponse = Invoke-WebRequest @PSBoundParameters -ErrorAction Stop

		} catch [System.UriFormatException] {

			#Catch URI Format errors. Likely module scope url is not set; Connect-R1Session should be run.
			$PSCmdlet.ThrowTerminatingError(

				[System.Management.Automation.ErrorRecord]::new(

					"$PSItem Run Connect-R1Session",
					'psRadiantOne.NoSession',
					[System.Management.Automation.ErrorCategory]::ConnectionError,
					$PSItem

				)

			)

		} catch {
			#catch other errors

			If ($null -ne $($PSItem)) {

				$Script:psRadiantOneSession.LastError = $PSItem
				$Script:psRadiantOneSession.LastErrorTime = Get-Date

				$ErrorID = $PSItem | Select-Object -ExpandProperty FullyQualifiedErrorId

				try {

					$ErrorDetails = $PSItem.ErrorDetails | ConvertFrom-Json -ErrorAction Stop
					$ValidJson = $true

				} catch {

					$ValidJson = $false
					$ErrorMessage = $null

				} finally {

					if ($ValidJson) {

						#The RadiantOne ClientError object reports status, code and message.
						#The authentication endpoints instead report a reason.
						switch ($ErrorDetails) {

							{ $null -ne $PSItem.message } {
								$ErrorMessage = $ErrorDetails | Select-Object -ExpandProperty message
							}
							{ $null -ne $PSItem.reason } {
								$ErrorMessage = $ErrorDetails | Select-Object -ExpandProperty reason
							}
							{ $null -ne $PSItem.code } {
								$ErrorID = $ErrorID, $ErrorDetails.code -join ','
							}

						}

					} else {

						$ErrorMessage = $PSItem.ErrorDetails

					}

					#throw the error
					$PSCmdlet.ThrowTerminatingError(

						[System.Management.Automation.ErrorRecord]::new(

							[System.Exception]::new($ErrorMessage),
							$ErrorID,
							[System.Management.Automation.ErrorCategory]::NotSpecified,
							$PSItem

						)

					)

				}

			}

		} finally {

			#Add Command Data to module scope session variable
			$Script:psRadiantOneSession.LastCommand = Get-ParentFunction | Select-Object -ExpandProperty CommandData
			$Script:psRadiantOneSession.LastCommandResults = $APIResponse
			$Script:psRadiantOneSession.LastCommandTime = Get-Date

			#If Session Variable passed as argument
			If ($PSCmdlet.ParameterSetName -eq 'SessionVariable') {

				#Make the WebSession available in the module scope
				$Script:psRadiantOneSession.WebSession = $(Get-Variable $(Get-Variable SessionVariable).Value).Value

			}

			#If Command Succeeded
			if ($?) {

				#Status code indicates success
				If ($APIResponse.StatusCode -match '^20\d$') {

					#Pass APIResponse to Get-R1Response
					$APIResponse | Get-R1Response

				}

			}

		}

	}

	End { }

}
