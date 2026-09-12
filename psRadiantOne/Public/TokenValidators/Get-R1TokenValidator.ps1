# .ExternalHelp psRadiantOne-help.xml
function Get-R1TokenValidator {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.ExternalTokenValidator')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Name'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'external_token_validators'

		if ($PSCmdlet.ParameterSetName -eq 'Name') {

			$Path = "$Path/$($name | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ExternalTokenValidator

		}

	}#process

	End { }#end

}
