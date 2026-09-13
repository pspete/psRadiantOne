# .ExternalHelp psRadiantOne-help.xml
function Get-R1DirectoryEntryMember {
	[CmdletBinding(DefaultParameterSetName = 'Explicit')]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'Dynamic'
		)]
		[switch]$Dynamic
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Membership = if ($Dynamic) { 'dynamic' } else { 'explicit' }

		$URI = Resolve-R1ServiceUrl -Service Browser -Path "directory_browser/$($dn | Get-EscapedString)/members/$Membership"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result

		}

	}#process

	End { }#end

}
