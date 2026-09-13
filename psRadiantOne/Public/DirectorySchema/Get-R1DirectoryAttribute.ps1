# .ExternalHelp psRadiantOne-help.xml
function Get-R1DirectoryAttribute {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.DirectorySchemaAttribute')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Attribute'
		)]
		[ValidateLength(1, 500)]
		[string]$attribute,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[bool]$includeAllProperties,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[bool]$includeSuperior,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[bool]$isUserDefined,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[string[]]$attributeObjectClasses
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Attribute') {

			$URI = Resolve-R1ServiceUrl -Service Schema -Path "attributes/$($attribute | Get-EscapedString)"

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.DirectorySchemaAttribute

			}

		} else {

			$Query = $PSBoundParameters | Get-Parameter

			#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
			foreach ($Flag in 'includeAllProperties', 'includeSuperior', 'isUserDefined') {

				if ($Query.ContainsKey($Flag)) {

					$Query[$Flag] = "$($Query[$Flag])".ToLowerInvariant()

				}

			}

			$Path = 'attributes'

			$QueryString = $Query | ConvertTo-QueryString

			if (-not ([string]::IsNullOrEmpty($QueryString))) {

				$Path = "$Path`?$QueryString"

			}

			$URI = Resolve-R1ServiceUrl -Service Schema -Path $Path

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result) {

				#meta reports which form the collection takes: the full attributes, or just their names
				if ($Result.meta) {

					$Result.attributes | Add-CustomType -Type psRadiantOne.DirectorySchemaAttribute

				} else {

					$Result.attributes

				}

			}

		}

	}#process

	End { }#end

}
