function Get-ComputedPrecedent {
	<#
.SYNOPSIS
Outputs a computed precedentAttributes entry.

.DESCRIPTION
Builds the precedentAttributes entry which marks an attribute in the object model as computed.
An attribute is only presented as computed if its attributes entry carries a matching precedent,
so one is needed alongside every computedAttributes entry.

New precedents are created at NORMAL priority. A priority change must be sent as a separate
request, as the server discards the computed attribute if one shares a request with a
computedAttributes write.

.PARAMETER Name
The name of the computed attribute.

.EXAMPLE
Get-ComputedPrecedent -Name 'cn'

Outputs the computed precedent for the cn attribute

.OUTPUTS
PSCustomObject
#>
	[CmdletBinding()]
	[OutputType('System.Management.Automation.PSCustomObject')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Name
	)

	Process {

		[pscustomobject]@{
			name                = $Name
			origin              = 'computed'
			priority            = 'NORMAL'
			tags                = @()
			isUpdatable         = $false
			isSearchable        = $false
			canModifySearchable = $true
			canModifyUpdatable  = $false
		}

	}

}
