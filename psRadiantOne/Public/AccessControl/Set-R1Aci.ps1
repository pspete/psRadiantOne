# .ExternalHelp psRadiantOne-help.xml
function Set-R1Aci {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[int64]$aciId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateLength(1, 5000)]
		[string]$baseDn,

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

		$Path = "access_control/acis/$($aciId | Get-EscapedString)?baseDn=$($baseDn | Get-EscapedString)"
		$URI = Resolve-R1ServiceUrl -Service Settings -Path $Path

		#Retrieve the ACI and send it back with the supplied values applied over it, so a property
		#left unspecified keeps its current value.
		$Existing = Get-R1Aci -aciId $aciId -baseDn $baseDn

		#aciString is left out: the server builds it from the other properties, and sending the one
		#it built for the ACI as it stands is refused with 409.
		$Template = [ordered]@{
			parsable                = $false
			name                    = $null
			targetDn                = $null
			targetScope             = $null
			targetFilter            = $null
			includeTargetAttributes = $false
			targetAttributes        = $null
			permsType               = $null
			selectedOperations      = @()
			loaOperator             = $null
			loaLevel                = $null
			daysOfWeek              = @()
			timeRanges              = @()
			applyUserDns            = @()
			applyGroupDns           = @()
			applyIps                = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove baseDn, aciId) -Fallback $Existing

		foreach ($Collection in 'targetAttributes', 'selectedOperations', 'daysOfWeek', 'timeRanges', 'applyUserDns', 'applyGroupDns', 'applyIps') {

			#A null targetAttributes is how every attribute is expressed, and is not an empty list
			if ($Request.Contains($Collection) -and ($null -ne $Request[$Collection])) {

				$Request[$Collection] = @($Request[$Collection])

			}

		}

		#The control panel leaves these out rather than sending them empty
		foreach ($Optional in 'loaOperator', 'applyGroupDns', 'applyIps') {

			if ((-not ($PSBoundParameters.ContainsKey($Optional))) -and (-not ($Request[$Optional]))) {

				$Request.Remove($Optional)

			}

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess("$aciId ($baseDn)", 'Update ACI')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
