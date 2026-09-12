# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContextChild {
	[CmdletBinding()]
	[OutputType('psRadiantOne.NamingContextNode')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(Mandatory = $false)]
		[ValidateSet('ACTIVE', 'OFFLINE', 'CACHE_NO_REFRESH', 'CACHE_PERIODIC', 'CACHE_REAL_TIME', 'NON_CACHED', 'STORES')]
		[string]$typeFilter,

		[parameter(Mandatory = $false)]
		[ValidateRange(1, 10000)]
		[int]$limit
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = $PSBoundParameters | Get-Parameter -ParametersToRemove dn

		Get-R1NamingContextNodeList -Path "naming_contexts/$($dn | Get-EscapedString)/children" -Query $Query

	}#process

	End { }#end

}
