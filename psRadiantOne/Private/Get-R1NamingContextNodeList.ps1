function Get-R1NamingContextNodeList {
	<#
	.SYNOPSIS
	Returns every naming context node from a paged node list endpoint.

	.DESCRIPTION
	The naming context list endpoints return a page of nodes alongside the limit and offset which
	produced it. No total is reported, so the end of the collection can only be recognised by a
	page holding fewer nodes than the limit asked for.

	This helper walks those pages, requesting each in turn and emitting the nodes as it goes, so
	the commands which list naming contexts return the whole collection rather than its first page.

	.PARAMETER Path
	The path of the node list operation within the directory namespace service.

	.PARAMETER Query
	The query parameters to send. The offset is managed here and any value supplied is overwritten.

	.EXAMPLE
	Get-R1NamingContextNodeList -Path 'naming_contexts' -Query $Query

	.OUTPUTS
	psRadiantOne.NamingContextNode
	#>
	[CmdletBinding()]
	[OutputType('psRadiantOne.NamingContextNode')]
	param(
		[parameter(Mandatory = $true)]
		[string]$Path,

		[parameter(Mandatory = $false)]
		[hashtable]$Query = @{ }
	)

	Process {

		$Offset = 0

		do {

			$Query['offset'] = $Offset

			$QueryString = $Query | ConvertTo-QueryString

			$RequestPath = $Path

			if (-not ([string]::IsNullOrEmpty($QueryString))) {

				$RequestPath = "$RequestPath`?$QueryString"

			}

			$URI = Resolve-R1ServiceUrl -Service Namespace -Path $RequestPath

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			$Nodes = @($Result.nodes)

			if ($Nodes.Count -gt 0) {

				$Nodes | Add-CustomType -Type psRadiantOne.NamingContextNode

			}

			$PageSize = $Result.pagination.limit

			$Offset = $Offset + $Nodes.Count

			#A page holding fewer nodes than were asked for is the last one
			$MorePages = ($Nodes.Count -gt 0) -and ($null -ne $PageSize) -and ($Nodes.Count -ge $PageSize)

		} while ($MorePages)

	}

}
