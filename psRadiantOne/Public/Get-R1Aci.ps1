# .ExternalHelp psRadiantOne-help.xml
function Get-R1Aci {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.Aci')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'AciId'
		)]
		[int64]$aciId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'AciId'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'All'
		)]
		[ValidateLength(1, 5000)]
		[string]$baseDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'AciId') {

			#baseDn identifies where the aci lives, and is required when requesting a single aci
			$Path = "access_control/acis/$($aciId | Get-EscapedString)?baseDn=$($baseDn | Get-EscapedString)"

		} else {

			$Path = 'access_control/acis'

			if ($PSBoundParameters.ContainsKey('baseDn')) {

				$Path = "$Path`?baseDn=$($baseDn | Get-EscapedString)"

			}

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Aci

		}

	}#process

	End { }#end

}
