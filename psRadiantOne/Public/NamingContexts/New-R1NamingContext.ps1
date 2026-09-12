# .ExternalHelp psRadiantOne-help.xml
function New-R1NamingContext {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.NewNamingContextResponse')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'naming_contexts'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, 'Add Root Naming Context')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.NewNamingContextResponse

			}

		}

	}#process

	End { }#end

}
