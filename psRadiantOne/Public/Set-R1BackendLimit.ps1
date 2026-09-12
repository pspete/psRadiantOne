# .ExternalHelp psRadiantOne-help.xml
function Set-R1BackendLimit {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$jndiPoolSize,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$jndiConnectTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$jndiOperationTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$ldapWriteOperationTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$jndiIdleTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$jdbcPoolSize,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$jdbcIdleTimeout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$jdbcPreparedStmtCache,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$srvRecordLimit
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'limits/backends'

		#Retrieve the current settings and send them back with the supplied values applied over
		#them, so a setting left unspecified keeps its current value.
		$Existing = Get-R1BackendLimit

		$Template = [ordered]@{
			jndiPoolSize              = 1000
			jndiConnectTimeout        = 7
			jndiOperationTimeout      = 0
			ldapWriteOperationTimeout = 0
			jndiIdleTimeout           = 5
			jdbcPoolSize              = 20
			jdbcIdleTimeout           = 15
			jdbcPreparedStmtCache     = 50
			srvRecordLimit            = 5
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Update Backend Limits')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
