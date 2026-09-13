# .ExternalHelp psRadiantOne-help.xml
function Publish-R1Schema {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[Alias('name')]
		[string[]]$schemaName
	)

	Begin {

		Assert-R1Session -RequireToken

		$SchemaList = [System.Collections.Generic.List[string]]::new()

	}#begin

	Process {

		foreach ($Name in $schemaName) {

			$SchemaList.Add($Name)

		}

	}#process

	End {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'schemas/published'

		if ($SchemaList.Count -eq 0) {

			$Body = '[]'

		} else {

			$Body = ConvertTo-R1JsonBody -Body @($SchemaList)

		}

		if ($PSCmdlet.ShouldProcess(($SchemaList -join ', '), 'Update Published Schemas')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#end

}
