# .ExternalHelp psRadiantOne-help.xml
function Set-R1JdbcDriverLibrary {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$libraries
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "jdbc_drivers/files/$($name | Get-EscapedString)/libraries"

		if ($libraries.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($libraries)

		}

		if ($PSCmdlet.ShouldProcess($name, "Set Driver Libraries ($($libraries.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
