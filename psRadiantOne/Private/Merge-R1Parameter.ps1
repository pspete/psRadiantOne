function Merge-R1Parameter {
	<#
	.SYNOPSIS
	Projects supplied parameters onto an ordered request template.

	.DESCRIPTION
	The RadiantOne settings endpoints expect a complete configuration object on update, not a
	partial one. Commands which update those settings therefore walk a fixed [ordered] template of
	the expected properties and, for each key, take the caller's bound value when supplied,
	otherwise falling back to either the corresponding property of the existing configuration or
	the template's own default value.

	This helper centralises that walk. The returned [ordered] hashtable preserves the template's
	key order and is ready to pipe to ConvertTo-R1JsonBody.

	.PARAMETER Template
	An [ordered] hashtable whose keys define the expected properties (and their order) and whose
	values are the defaults to use when a key is neither bound nor present in -Fallback.

	.PARAMETER BoundParameter
	The projected bound parameters (typically $PSBoundParameters | Get-Parameter). A key present
	here always wins.

	.PARAMETER Fallback
	Optional object holding the existing configuration. When supplied, an unbound key takes its
	value from this object's matching property instead of the template default.

	.EXAMPLE
	$Body = Merge-R1Parameter -Template $OrderedProperties -BoundParameter ($PSBoundParameters | Get-Parameter)

	.EXAMPLE
	$Body = Merge-R1Parameter -Template $OrderedProperties -BoundParameter $BoundParameters -Fallback $CurrentSettings

	.OUTPUTS
	System.Collections.Specialized.OrderedDictionary
	#>
	[CmdletBinding()]
	[OutputType('System.Collections.Specialized.OrderedDictionary')]
	param(
		[parameter(Mandatory = $true)]
		[System.Collections.Specialized.OrderedDictionary]$Template,

		[parameter(Mandatory = $true)]
		[hashtable]$BoundParameter,

		[parameter(Mandatory = $false)]
		[object]$Fallback
	)

	Process {

		$Merged = [ordered]@{ }

		foreach ($Key in $Template.Keys) {

			if ($BoundParameter.ContainsKey($Key)) {

				$Merged[$Key] = $BoundParameter[$Key]

			} elseif ($PSBoundParameters.ContainsKey('Fallback')) {

				$Merged[$Key] = $Fallback.$Key

			} else {

				$Merged[$Key] = $Template[$Key]

			}

		}

		$Merged

	}

}
