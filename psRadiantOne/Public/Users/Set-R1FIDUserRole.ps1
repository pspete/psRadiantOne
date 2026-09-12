# .ExternalHelp psRadiantOne-help.xml
function Set-R1FIDUserRole {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[a-zA-Z0-9_-]+$')]
		[string]$username,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[string[]]$roles
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Auth -Path "users/$($username | Get-EscapedString)/roles"

		if ($roles.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($roles)

		}

		if ($PSCmdlet.ShouldProcess($username, "Set FID User Roles: $($roles -join ', ')")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
