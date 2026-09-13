# .ExternalHelp psRadiantOne-help.xml
function Get-R1SchemaRelationshipTree {
	[CmdletBinding(DefaultParameterSetName = 'Root')]
	[OutputType('psRadiantOne.RelationshipNode')]
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
			ParameterSetName = 'Node'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$relationshipDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "schemas/$($schemaName | Get-EscapedString)/relationship_tree"

		if ($PSCmdlet.ParameterSetName -eq 'Node') {

			$Path = "$Path/$($relationshipDn | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.RelationshipNode

		}

	}#process

	End { }#end

}
