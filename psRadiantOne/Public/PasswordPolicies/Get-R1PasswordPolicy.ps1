# .ExternalHelp psRadiantOne-help.xml
function Get-R1PasswordPolicy {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'NewPolicy', Justification = 'Selects the parameter set, which the analyzer does not follow')]
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.PasswordPolicy')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'PolicyName'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$policyName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $false,
			ParameterSetName = 'NewPolicy'
		)]
		[switch]$NewPolicy
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		switch ($PSCmdlet.ParameterSetName) {

			'PolicyName' {

				#policyName is a required query parameter on this endpoint
				$Path = "password_policies/policy?policyName=$($policyName | Get-EscapedString)"

			}

			'NewPolicy' {

				#Returns an empty policy populated with the API's defaults
				$Path = 'password_policies/policy?newPolicy=true'

			}

			default {

				#The list endpoint returns the names of the configured policies
				$Path = 'password_policies'

			}

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			if ($PSCmdlet.ParameterSetName -eq 'All') {

				$Result

			} else {

				$Result | Add-CustomType -Type psRadiantOne.PasswordPolicy

			}

		}

	}#process

	End { }#end

}
