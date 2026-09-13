# .ExternalHelp psRadiantOne-help.xml
function Get-R1LibraryDependency {
	[CmdletBinding()]
	[OutputType('psRadiantOne.LibraryReference')]
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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "libraries/$($groupId | Get-EscapedString)/$($artifactId | Get-EscapedString)/$($version | Get-EscapedString)/dependencies"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.LibraryReference

		}

	}#process

	End { }#end

}
