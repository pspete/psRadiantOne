# .ExternalHelp psRadiantOne-help.xml
function Add-R1DataSourceSchemaLink {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Single'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Single'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$schemaName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Bulk'
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$schemaNames
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Bulk') {

			$URI = Resolve-R1ServiceUrl -Service Catalog -Path 'data_sources/link_schemas'

			$Body = ConvertTo-R1JsonBody -Body @($schemaNames)

			$Target = "$($schemaNames.Count) schema(s)"

		} else {

			$Query = @{ schemaName = $schemaName } | ConvertTo-QueryString

			$URI = Resolve-R1ServiceUrl -Service Catalog -Path "data_sources/$($name | Get-EscapedString)/link_schema`?$Query"

			$Body = $null

			$Target = $name

		}

		if ($PSCmdlet.ShouldProcess($Target, 'Link Schema')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

			if ($null -ne $Result) {

				$Result

			}

		}

	}#process

	End { }#end

}
