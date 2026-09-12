# .ExternalHelp psRadiantOne-help.xml
function New-R1NamingContextLink {
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
		[ValidateSet('STANDARD_LINK', 'MERGE_LINK')]
		[string]$linkType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$existingView
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/add_link"

		$Body = $PSBoundParameters | Get-Parameter -ParametersToRemove dn | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, "Add Child Link '$existingView'")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
