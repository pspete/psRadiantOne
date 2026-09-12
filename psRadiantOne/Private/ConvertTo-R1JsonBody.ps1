function ConvertTo-R1JsonBody {
	<#
	.SYNOPSIS
	Serialises a request body object to a JSON string for the RadiantOne API.

	.DESCRIPTION
	An array-safe wrapper around ConvertTo-Json for building request bodies.

	Windows PowerShell's ConvertTo-Json unwraps a single-element array when that array is the
	top-level pipeline input, so "@($item) | ConvertTo-Json" can emit an object instead of a
	one-element array. This helper always serialises via -InputObject, which is not subject to
	that unwrap, so a body whose root is a single-element collection still serialises as a JSON
	array. It also gives every request body a single consistent default depth.

	Windows PowerShell also serialises an empty array as "" rather than []. Properties named with
	-EmptyArrayProperty are restored to an empty JSON array in the output.

	.PARAMETER Body
	The object to serialise - typically a [hashtable] or [ordered] hashtable of the expected fields.

	.PARAMETER Depth
	ConvertTo-Json depth. Defaults to 10, enough for the deeply nested naming context bodies.

	.PARAMETER Compress
	Emit compact JSON with no whitespace.

	.PARAMETER EmptyArrayProperty
	Names of properties which must serialise as an empty array rather than an empty string.

	.EXAMPLE
	$Body = ConvertTo-R1JsonBody -Body @{ name = 'example'; enabled = $true }

	.EXAMPLE
	$Body = ConvertTo-R1JsonBody -Body $RequestBody -EmptyArrayProperty attributes

	.OUTPUTS
	System.String
	#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			Position = 0
		)]
		[object]$Body,

		[parameter(Mandatory = $false)]
		[int]$Depth = 10,

		[parameter(Mandatory = $false)]
		[switch]$Compress,

		[parameter(Mandatory = $false)]
		[string[]]$EmptyArrayProperty
	)

	Process {

		$Json = ConvertTo-Json -InputObject $Body -Depth $Depth -Compress:$Compress

		foreach ($Property in $EmptyArrayProperty) {

			$Json = $Json -replace ('("{0}"\s*:\s*)""' -f [regex]::Escape($Property)), '$1[]'

		}

		$Json

	}

}
