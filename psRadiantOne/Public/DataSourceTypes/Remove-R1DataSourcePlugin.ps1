# .ExternalHelp psRadiantOne-help.xml
function Remove-R1DataSourcePlugin {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$pluginName
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "meta/plugins/$($pluginName | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($pluginName, 'Delete Plugin')) {

			#The API answers this call with HTTP 500 and no error details even when the plugin is
			#removed, so an error here is checked against the plugin listing before it is reported:
			#gone from the listing means the delete worked despite the response, and only an error
			#which leaves the plugin still listed is a real failure.
			try {

				$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

			} catch {

				if (@(Get-R1DataSourcePlugin) | Where-Object { $PSItem.name -eq $pluginName }) {

					throw

				}

				Write-Warning "The API answered the removal of '$pluginName' with an error, but the plugin is gone."

			}

		}

	}#process

	End { }#end

}
