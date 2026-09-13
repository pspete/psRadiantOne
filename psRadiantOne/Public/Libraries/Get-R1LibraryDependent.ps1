# .ExternalHelp psRadiantOne-help.xml
function Get-R1LibraryDependent {
	[CmdletBinding()]
	[OutputType('psRadiantOne.Library')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$groupId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$artifactId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$version
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "libraries/$($groupId | Get-EscapedString)/$($artifactId | Get-EscapedString)/$($version | Get-EscapedString)/dependents"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Library

		}

	}#process

	End { }#end

}
