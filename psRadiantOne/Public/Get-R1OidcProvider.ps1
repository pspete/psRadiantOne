# .ExternalHelp psRadiantOne-help.xml
function Get-R1OidcProvider {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.OidcProvider')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'ConfigurationName'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$configurationName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'oidc_providers'

		if ($PSCmdlet.ParameterSetName -eq 'ConfigurationName') {

			$Path = "$Path/$($configurationName | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.OidcProvider

		}

	}#process

	End { }#end

}
