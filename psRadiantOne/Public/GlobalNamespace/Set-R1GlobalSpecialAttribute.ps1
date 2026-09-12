# .ExternalHelp psRadiantOne-help.xml
function Set-R1GlobalSpecialAttribute {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('MEMBER', 'UNIQUE_MEMBER')]
		[string]$memberAttribute
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'special_attributes/global'

		$Body = @{ memberAttribute = $memberAttribute } | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Global Special Attributes')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
