# .ExternalHelp psRadiantOne-help.xml
function Get-R1AccessToken {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.AccessToken')]
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

		$Path = 'access_tokens'

		if ($PSCmdlet.ParameterSetName -eq 'Name') {

			$Path = "$Path/$($name | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Auth -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.AccessToken

		}

	}#process

	End { }#end

}
