# .ExternalHelp psRadiantOne-help.xml
function Get-R1FileManagerDirectory {
	[CmdletBinding()]
	[OutputType('psRadiantOne.Directory')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$RequestPath = 'file_manager/directories'

		$Query = $PSBoundParameters | Get-Parameter

		if ($Query.Count -gt 0) {

			$RequestPath = "$RequestPath`?$($Query | ConvertTo-QueryString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $RequestPath

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Directory

		}

	}#process

	End { }#end

}
