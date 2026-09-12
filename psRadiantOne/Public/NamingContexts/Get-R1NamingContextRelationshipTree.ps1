# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContextRelationshipTree {
	[CmdletBinding(DefaultParameterSetName = 'Root')]
	[OutputType('psRadiantOne.RelationshipNode')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Node'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$relationshipDn,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'Node'
		)]
		[bool]$isRelatedObjectsOnly
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "naming_contexts/$($dn | Get-EscapedString)/relationship_tree"

		if ($PSCmdlet.ParameterSetName -eq 'Node') {

			$Path = "$Path/$($relationshipDn | Get-EscapedString)"

			$Query = $PSBoundParameters | Get-Parameter -ParametersToRemove dn, relationshipDn

			if ($Query.ContainsKey('isRelatedObjectsOnly')) {

				#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
				$Query['isRelatedObjectsOnly'] = "$($Query['isRelatedObjectsOnly'])".ToLowerInvariant()

				$Path = "$Path`?$($Query | ConvertTo-QueryString)"

			}

		}

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.RelationshipNode

		}

	}#process

	End { }#end

}
