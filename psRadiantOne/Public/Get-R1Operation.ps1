# .ExternalHelp psRadiantOne-help.xml
function Get-R1Operation {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.RefreshOperation')]
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

		$Path = 'operations'

		if ($PSCmdlet.ParameterSetName -eq 'Name') {

			$Path = "$Path/$($name | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.RefreshOperation

		}

	}#process

	End { }#end

}
