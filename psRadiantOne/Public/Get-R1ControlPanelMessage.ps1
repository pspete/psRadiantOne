# .ExternalHelp psRadiantOne-help.xml
function Get-R1ControlPanelMessage {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ControlPanelMessage')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('Banner', 'Motd')]
		[string]$Type
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "controlpanel/messages/$($Type.ToLowerInvariant())"

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ControlPanelMessage

		}

	}#process

	End { }#end

}
