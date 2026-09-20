# .ExternalHelp psRadiantOne-help.xml
function Set-R1NamingContextContentProperty {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$rdnName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$rdnValues,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$primaryKey
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/content/properties"

		#Retrieve the current properties and send them back with the supplied values applied over
		#them, so a property left unspecified keeps its current value.
		$Existing = Get-R1NamingContextContentProperty -dn $dn

		#schema and type are maintained by the API and are sent back unchanged
		$Template = [ordered]@{
			rdnName    = $null
			rdnValues  = @()
			primaryKey = $null
			schema     = $null
			type       = 'CONTENT'
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn) -Fallback $Existing

		$Request['rdnValues'] = [string[]]@($Request['rdnValues'] | Where-Object { $null -ne $_ })

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty rdnValues

		if ($PSCmdlet.ShouldProcess($dn, 'Update Content Properties')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
