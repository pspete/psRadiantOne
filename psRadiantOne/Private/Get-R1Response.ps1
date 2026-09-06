function Get-R1Response {
	<#
	.SYNOPSIS
	Receives and returns the content of the web response from the RadiantOne API

	.DESCRIPTION
	Accepts a WebResponseObject, as returned from the RadiantOne API by Invoke-WebRequest, and
	returns its content in the form required by the command which initiated the request.

	JSON content is returned as an object. Content of any other type is returned unaltered, so
	that the commands which download files, LDIF exports, logs and schema files receive the raw
	response content.

	.PARAMETER APIResponse
	A WebResponseObject, as returned from the RadiantOne API using Invoke-WebRequest

	.EXAMPLE
	$WebResponseObject | Get-R1Response

	Parses, if required, and returns the content of $WebResponseObject

	.OUTPUTS
	System.Object
	#>
	[CmdletBinding()]
	[OutputType('System.Object')]
	param(
		[parameter(
			Position = 0,
			Mandatory = $true,
			ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[Microsoft.PowerShell.Commands.WebResponseObject]$APIResponse
	)

	BEGIN { }#begin

	PROCESS {

		if ($APIResponse.Content) {

			$R1Response = $APIResponse.Content
			$ContentType = $APIResponse.Headers['Content-Type']

			if ($ContentType -match 'json') {

				#Invoke-WebRequest only auto-decodes recognized text content types to a string;
				#unrecognized ones come back as a raw byte[], so decode before parsing
				if ($APIResponse.Content -is [Byte[]]) {

					$RawContent = [System.Text.Encoding]::UTF8.GetString($APIResponse.Content)

				} else {

					$RawContent = $APIResponse.Content

				}

				if (-not ([string]::IsNullOrWhiteSpace($RawContent))) {

					$R1Response = ConvertFrom-Json -InputObject $RawContent

				}

			}

			$R1Response

		}

	}#process

	END { }#end

}
