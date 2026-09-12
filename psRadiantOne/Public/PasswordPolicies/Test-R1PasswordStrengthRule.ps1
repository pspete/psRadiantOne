# .ExternalHelp psRadiantOne-help.xml
function Test-R1PasswordStrengthRule {
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$pattern
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'password_policies/test_strength_rule'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		try {

			#A valid pattern returns 204 with no content; an invalid one returns 400 with the reason
			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body
			$true

		} catch {

			Write-Verbose "Pattern rejected: $($PSItem.Exception.Message)"
			$false

		}

	}#process

	End { }#end

}
