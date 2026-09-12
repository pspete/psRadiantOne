# .ExternalHelp psRadiantOne-help.xml
function Test-R1Aci {
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 1000)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 50000)]
		[string]$aciString,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$parsable,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$targetDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('BASE', 'ONE', 'SUBTREE')]
		[string]$targetScope,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 5000)]
		[string]$targetFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$includeTargetAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$targetAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('ALLOW', 'DENY')]
		[string]$permsType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('READ', 'WRITE', 'SEARCH', 'SELF_WRITE', 'ADD', 'PROXY', 'DELETE', 'MOVE_CURRENT', 'COMPARE', 'MOVE_FUTURE')]
		[string[]]$selectedOperations,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(0, 10)]
		[string]$loaOperator,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, 4)]
		[int]$loaLevel,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY')]
		[string[]]$daysOfWeek,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$timeRanges,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$applyUserDns,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$applyGroupDns,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$applyIps
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'access_control/acis/validate_parsable'

		$Request = $PSBoundParameters | Get-Parameter

		foreach ($Collection in 'targetAttributes', 'selectedOperations', 'daysOfWeek', 'timeRanges', 'applyUserDns', 'applyGroupDns', 'applyIps') {

			if ($Request.Contains($Collection)) {

				$Request[$Collection] = @($Request[$Collection])

			}

		}

		$Body = $Request | ConvertTo-R1JsonBody

		#The endpoint is a GET which carries the ACI as its request body
		Invoke-R1RestMethod -Uri $URI -Method GET -Body $Body

	}#process

	End { }#end

}
