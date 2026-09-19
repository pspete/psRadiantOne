# .ExternalHelp psRadiantOne-help.xml
function Get-R1PasswordPolicy {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'NewPolicy', Justification = 'Selects the parameter set, which the analyzer does not follow')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Default', Justification = 'Selects the parameter set, which the analyzer does not follow')]
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
			ParameterSetName = 'Default'
		)]
		[switch]$Default,

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

			'Default' {

				#An empty policyName asks for the default policy, which is how the control panel
				#reads it. policyName is required on this endpoint whichever policy is asked for.
				$Path = 'password_policies/policy?policyName='

			}

			'NewPolicy' {

				#Returns an empty policy populated with the API's defaults
				$Path = 'password_policies/policy?policyName=&newPolicy=true'

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
