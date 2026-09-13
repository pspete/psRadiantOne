# .ExternalHelp psRadiantOne-help.xml
function Set-R1LibraryDependency {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
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
		[string]$version,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$dependencies
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "libraries/$($groupId | Get-EscapedString)/$($artifactId | Get-EscapedString)/$($version | Get-EscapedString)/dependencies"

		if ($dependencies.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($dependencies)

		}

		if ($PSCmdlet.ShouldProcess("$groupId`:$artifactId`:$version", "Set Dependencies ($($dependencies.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
