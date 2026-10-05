Function ConvertTo-R1Rdn {
	<#
	.SYNOPSIS
	Builds an RDN from an attribute name and value.

	.DESCRIPTION
	Escapes the value as RFC 4514 requires and joins it to the attribute name, so that a value such
	as 'Smith, John' names one entry rather than splitting the DN.

	The characters \ , + " < > ; are escaped wherever they appear, as are a leading space or # and a
	trailing space.

	.PARAMETER Attribute
	The naming attribute, such as cn, uid or ou.

	.PARAMETER Value
	The unescaped value of the naming attribute.

	.EXAMPLE
	ConvertTo-R1Rdn -Attribute cn -Value 'Smith, John'

	Outputs cn=Smith\, John.

	.OUTPUTS
	System.String
	#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Attribute,

		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Value
	)

	$Escaped = $Value -replace '([\\,+"<>;])', '\$1'

	if ($Escaped.EndsWith(' ')) {
		$Escaped = $Escaped.Substring(0, $Escaped.Length - 1) + '\ '
	}

	if ($Escaped -match '^[ #]') {
		$Escaped = "\$Escaped"
	}

	"$Attribute=$Escaped"

}
