function ConvertTo-R1Timestamp {
	<#
	.SYNOPSIS
	Formats a datetime as the UTC timestamp the RadiantOne API expects.

	.DESCRIPTION
	Converts a datetime to UTC and formats it as yyyy-MM-ddTHH:mm:ss.fffZ, the form the control panel
	sends and the API returns.

	The format is applied with the invariant culture. The ":" in a custom format string is the
	culture's time separator, so formatting under a culture which does not use a colon - Finnish, for
	one - would otherwise produce a timestamp the API rejects.

	.PARAMETER Timestamp
	The datetime to format. Converted to UTC.

	.EXAMPLE
	ConvertTo-R1Timestamp -Timestamp (Get-Date).AddDays(90)

	Returns the date 90 days from now as a UTC timestamp, e.g. 2027-09-12T17:42:49.987Z

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
		[datetime]$Timestamp
	)

	Process {

		$Timestamp.ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ss.fffZ', [System.Globalization.CultureInfo]::InvariantCulture)

	}

}
