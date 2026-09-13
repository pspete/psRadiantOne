# .ExternalHelp psRadiantOne-help.xml
function Set-R1DirectoryEntryMember {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Explicit')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$members,

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

		if ($members.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($members)

		}

		if ($PSCmdlet.ShouldProcess($dn, "Set $Membership Members ($($members.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
