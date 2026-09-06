# .ExternalHelp psRadiantOne-help.xml
function New-R1AccessToken {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 1000)]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('CONFIG', 'SCIM', 'REST')]
		[string]$apiType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[datetime]$expiresOn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$targetDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path 'access_tokens'

		$Request = $PSBoundParameters | Get-Parameter

		if ($PSBoundParameters.ContainsKey('expiresOn')) {

			$Request['expiresOn'] = $expiresOn.ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fffZ')

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, 'Create Access Token')) {

			Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
