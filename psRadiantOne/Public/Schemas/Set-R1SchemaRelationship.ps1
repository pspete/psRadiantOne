# .ExternalHelp psRadiantOne-help.xml
function Set-R1SchemaRelationship {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
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
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$relationshipId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$source,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$sourceAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$dest,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$destAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$tags
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/relationships/$($relationshipId | Get-EscapedString)"

		#Retrieve the current relationship and send it back with the supplied values applied over
		#it, so a property left unspecified keeps its current value.
		$Existing = Get-R1SchemaRelationship -schemaName $schemaName -relationshipId $relationshipId

		$Template = [ordered]@{
			id          = $relationshipId
			parent      = $null
			source      = $null
			sourceAttrs = @()
			dest        = $null
			destAttrs   = @()
			tags        = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove schemaName, relationshipId) -Fallback $Existing

		foreach ($Collection in 'sourceAttrs', 'destAttrs', 'tags') {

			$Request[$Collection] = @($Request[$Collection])

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty sourceAttrs, destAttrs, tags

		if ($PSCmdlet.ShouldProcess($relationshipId, 'Update Relationship')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
