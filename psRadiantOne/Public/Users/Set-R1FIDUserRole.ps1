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

		#The roles endpoint is deprecated in the API definition and answers 404 here, so the roles
		#are set on the user itself, which is what the control panel updates.
		if ($PSCmdlet.ShouldProcess($username, "Set FID User Roles: $($roles -join ', ')")) {

			Set-R1FIDUser -username $username -roles $roles -Confirm:$false

		}

	}#process

	End { }#end

}
