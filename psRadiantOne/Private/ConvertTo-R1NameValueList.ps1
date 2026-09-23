function ConvertTo-R1NameValueList {
	<#
	.SYNOPSIS
	Expands dictionaries into the name/value item lists the API expects.

	.DESCRIPTION
	Several request bodies carry a list of items, each pairing a name with a value, such as
	@{ name = 'cn'; values = @('User One') }. This helper lets a command accept a plain dictionary
	instead, with one entry per item, and expands it into that list.

	A dictionary holding both the key and value properties is taken to already be an item, and any
	other object is too; both are output unchanged, so input already in the API's shape still works.

	.PARAMETER InputObject
	Dictionaries to expand, items already in the API's shape, or a mix of both.

	.PARAMETER KeyName
	The property of each item holding the name.

	.PARAMETER ValueName
	The property of each item holding the value.

	.PARAMETER MultiValued
	Always send each value as an array, even when a single value is supplied.

	.EXAMPLE
	ConvertTo-R1NameValueList -InputObject @{ cn = 'User One'; objectClass = 'top', 'person' } -ValueName values -MultiValued

	Outputs @{ name = 'cn'; values = @('User One') } and @{ name = 'objectClass'; values = @('top', 'person') }.

	.EXAMPLE
	ConvertTo-R1NameValueList -InputObject @{ maxHistory = '10' } -KeyName key

	Outputs @{ key = 'maxHistory'; value = '10' }.

	.OUTPUTS
	System.Collections.Specialized.OrderedDictionary
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $true)]
		[AllowEmptyCollection()]
		[AllowNull()]
		[object[]]$InputObject,

		[parameter(Mandatory = $false)]
		[string]$KeyName = 'name',

		[parameter(Mandatory = $false)]
		[string]$ValueName = 'value',

		[parameter(Mandatory = $false)]
		[switch]$MultiValued
	)

	Process {

		foreach ($Item in $InputObject) {

			if ($null -eq $Item) { continue }

			if (($Item -is [System.Collections.IDictionary]) -and -not ($Item.Contains($KeyName) -and $Item.Contains($ValueName))) {

				foreach ($Key in $Item.Keys) {

					$Value = if ($MultiValued) { , @($Item[$Key]) } else { $Item[$Key] }

					[ordered]@{ $KeyName = "$Key"; $ValueName = $Value }

				}

			} else {

				$Item

			}

		}

	}

}
