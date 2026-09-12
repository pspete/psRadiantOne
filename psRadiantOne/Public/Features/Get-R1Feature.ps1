# .ExternalHelp psRadiantOne-help.xml
function Get-R1Feature {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.FeatureFlag')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'FlagId'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$flagId
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'features'

		if ($PSCmdlet.ParameterSetName -eq 'FlagId') {

			$Path = "$Path/$($flagId | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.FeatureFlag

		}

	}#process

	End { }#end

}
