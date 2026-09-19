# .ExternalHelp psRadiantOne-help.xml
function Initialize-R1Cache {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.LaunchedTask')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('label')]
		[string]$dn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[bool]$useLdifz = $false
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "caches/$($dn | Get-EscapedString)/initialize"

		#Initializes from a snapshot of the virtual view, as the control panel does by default
		$Body = [ordered]@{
			useExistingLdif = $false
			useLdifz        = $useLdifz
		} | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, 'Initialize Persistent Cache')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.LaunchedTask

			}

		}

	}#process

	End { }#end

}
