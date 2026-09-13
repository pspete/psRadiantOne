# .ExternalHelp psRadiantOne-help.xml
function Get-R1SchemaRelationship {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.Relationship')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$schemaName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'RelationshipId'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$relationshipId
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "schemas/$($schemaName | Get-EscapedString)/relationships"

		if ($PSCmdlet.ParameterSetName -eq 'RelationshipId') {

			$Path = "$Path/$($relationshipId | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Relationship

		}

	}#process

	End { }#end

}
