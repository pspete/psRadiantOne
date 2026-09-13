# .ExternalHelp psRadiantOne-help.xml
function Get-R1Schema {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.SchemaProperties')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'SchemaName'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$schemaName,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[bool]$includeLinkedSchemas
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'SchemaName') {

			$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)"

		} else {

			$Path = 'schemas'

			$Query = $PSBoundParameters | Get-Parameter

			if ($Query.ContainsKey('includeLinkedSchemas')) {

				#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
				$Query['includeLinkedSchemas'] = "$($Query['includeLinkedSchemas'])".ToLowerInvariant()

				$Path = "$Path`?$($Query | ConvertTo-QueryString)"

			}

			$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		}

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.SchemaProperties

		}

	}#process

	End { }#end

}
