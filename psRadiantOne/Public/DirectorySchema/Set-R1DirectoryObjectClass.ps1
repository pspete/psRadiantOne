# .ExternalHelp psRadiantOne-help.xml
function Set-R1DirectoryObjectClass {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[string]$objectClass,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$superClass,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isAuxiliary,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$requiredAttrs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$optionalAttrs
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Schema -Path "object_classes/$($objectClass | Get-EscapedString)"

		#Retrieve the current definition and send it back with the supplied values applied over it,
		#so a property left unspecified keeps its current value.
		$Existing = Get-R1DirectoryObjectClass -objectClass $objectClass

		#oid and isUserDefined are maintained by the API and are sent back unchanged
		$Template = [ordered]@{
			objectClass    = $null
			superClass     = $null
			oid            = $null
			isUserDefined  = $null
			isAuxiliary    = $false
			requiredAttrs  = @()
			optionalAttrs  = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		foreach ($Collection in 'requiredAttrs', 'optionalAttrs') {

			$Request[$Collection] = @($Request[$Collection])

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty requiredAttrs, optionalAttrs

		if ($PSCmdlet.ShouldProcess($objectClass, 'Update Object Class')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
