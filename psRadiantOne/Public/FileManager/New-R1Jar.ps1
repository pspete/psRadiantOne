# .ExternalHelp psRadiantOne-help.xml
function New-R1Jar {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.JarBuildResult')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('ALL', 'SYNC', 'INTERCEPT', 'CUSTOM_OBJECTS', 'CHANGE_MESSAGE_CONVERTERS')]
		[string]$type
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ type = $type } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "file_manager/build_jar`?$Query"

		if ($PSCmdlet.ShouldProcess($type, 'Build Jar')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.JarBuildResult

			}

		}

	}#process

	End { }#end

}
