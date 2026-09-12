function ConvertTo-R1SecretBody {
	<#
	.SYNOPSIS
	Serialises a request body that carries a plaintext secret to UTF8 bytes.

	.DESCRIPTION
	Any command which decodes a SecureString and sends the plaintext in a JSON request body must
	hand Invoke-R1RestMethod a byte[] rather than a String, so that Windows PowerShell
	ParameterBinding and Module Logging cannot capture the plaintext value.
	See https://github.com/pspete/psPAS/issues/602

	Serialises the body with ConvertTo-R1JsonBody and returns the result as a UTF8 byte array.

	.PARAMETER InputObject
	The object to serialise.

	.PARAMETER Depth
	ConvertTo-Json depth. Defaults to 10.

	.PARAMETER EmptyArrayProperty
	Names of properties which must serialise as an empty array rather than an empty string.

	.EXAMPLE
	$Body | ConvertTo-R1SecretBody

	Serialises $Body and returns the request body as a UTF8 byte array.

	.OUTPUTS
	System.Byte[]
	#>
	[CmdletBinding()]
	[OutputType('System.Byte[]')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			Position = 0
		)]
		[object]$InputObject,

		[parameter(Mandatory = $false)]
		[int]$Depth = 10,

		[parameter(Mandatory = $false)]
		[string[]]$EmptyArrayProperty
	)

	Process {

		$Json = ConvertTo-R1JsonBody -Body $InputObject -Depth $Depth -EmptyArrayProperty $EmptyArrayProperty

		#Leading comma keeps the result a byte[] rather than being unrolled to object[] by the pipeline
		, [System.Text.Encoding]::UTF8.GetBytes($Json)

	}

}
