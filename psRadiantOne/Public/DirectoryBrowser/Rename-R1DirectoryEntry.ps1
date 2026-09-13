# .ExternalHelp psRadiantOne-help.xml
function Rename-R1DirectoryEntry {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
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
		[ValidateNotNullOrEmpty()]
		[string]$newRdn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Browser -Path "directory_browser/$($dn | Get-EscapedString)/mod_rdn"

		$Body = @{ newRdn = $newRdn } | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, "Rename to $newRdn")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
