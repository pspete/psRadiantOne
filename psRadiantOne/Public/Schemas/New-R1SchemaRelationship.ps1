# .ExternalHelp psRadiantOne-help.xml
function New-R1SchemaRelationship {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
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
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$source,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$sourceAttrs,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dest,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$destAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[Alias('relationshipId')]
		[string]$id,

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

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/relationships"

		$Request = $PSBoundParameters | Get-Parameter -ParametersToRemove schemaName

		foreach ($Collection in 'sourceAttrs', 'destAttrs', 'tags') {

			if ($Request.Contains($Collection)) {

				$Request[$Collection] = @($Request[$Collection])

			}

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($schemaName, "Create Relationship $source to $dest")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.Relationship

			}

		}

	}#process

	End { }#end

}
