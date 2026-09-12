# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContext {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.NamingContextNode')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Dn'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[bool]$activeOnly,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[string[]]$datasources,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[ValidateLength(0, 1000)]
		[string]$searchFilter,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[ValidateSet('ACTIVE', 'OFFLINE', 'CACHE_NO_REFRESH', 'CACHE_PERIODIC', 'CACHE_REAL_TIME', 'NON_CACHED', 'STORES')]
		[string]$typeFilter,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[ValidateRange(1, 10000)]
		[int]$limit
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Dn') {

			$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)"

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.NamingContextNode

			}

		} else {

			$Query = $PSBoundParameters | Get-Parameter

			#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
			if ($Query.ContainsKey('activeOnly')) {

				$Query['activeOnly'] = "$($Query['activeOnly'])".ToLowerInvariant()

			}

			Get-R1NamingContextNodeList -Path 'naming_contexts' -Query $Query

		}

	}#process

	End { }#end

}
