# .ExternalHelp psRadiantOne-help.xml
function Test-R1AdapToken {
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Token,

		[parameter(Mandatory = $false)]
		[switch]$PassThru
	)

	Begin {

		Assert-R1Session

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'adap-token/validate'

		$RequestParameters = @{
			URI    = $URI
			Method = 'POST'
		}

		if ($PSBoundParameters.ContainsKey('Token')) {

			$RequestParameters.Add('Headers', @{ Authorization = "Bearer $Token" })

		}

		try {

			$Result = Invoke-R1RestMethod @RequestParameters

		} catch {

			#The endpoint reports a missing, malformed or invalid token as 401
			Write-Verbose "ADAP token validation failed: $($PSItem.Exception.Message)"
			return $false

		}

		if ($PassThru) {

			$Result

		} else {

			$null -ne $Result.targetDn

		}

	}#process

	End { }#end

}
