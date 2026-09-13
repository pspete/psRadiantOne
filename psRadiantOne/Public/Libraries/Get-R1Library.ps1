# .ExternalHelp psRadiantOne-help.xml
function Get-R1Library {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.Library')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Coordinates'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$groupId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Coordinates'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$artifactId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Coordinates'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$version
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Coordinates') {

			$URI = Resolve-R1ServiceUrl -Service Catalog -Path "libraries/$($groupId | Get-EscapedString)/$($artifactId | Get-EscapedString)/$($version | Get-EscapedString)"

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.Library

			}

		} else {

			$PageNumber = 1

			do {

				$URI = Resolve-R1ServiceUrl -Service Catalog -Path "libraries`?pageNumber=$PageNumber"

				$Result = Invoke-R1RestMethod -Uri $URI -Method GET

				if ($null -ne $Result.result) {

					$Result.result | Add-CustomType -Type psRadiantOne.Library

				}

				$PageNumber++

			} while ($PageNumber -le $Result.totalPages)

		}

	}#process

	End { }#end

}
