# .ExternalHelp psRadiantOne-help.xml
function Set-R1SecondaryObject {
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
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$primaryObject,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[object]$finalOutput,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$joins,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$attributeMappings,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$inputSources,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[object[]]$joinComputedAttributes
	)

	Begin {

		Assert-R1Session -RequireToken

		$ArrayProperties = 'joins', 'attributeMappings', 'inputSources', 'joinComputedAttributes'

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/object_builder/primary_objects/$($primaryObject | Get-EscapedString)/objects"

		#Retrieve the current object model and send it back with the supplied sections applied over
		#it, so a section left unspecified keeps its current content.
		$Existing = Get-R1SecondaryObject -dn $dn -primaryObject $primaryObject

		$Template = [ordered]@{
			finalOutput            = $null
			joins                  = @()
			attributeMappings      = @()
			inputSources           = @()
			joinComputedAttributes = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove dn, primaryObject) -Fallback $Existing

		foreach ($Property in $ArrayProperties) {

			$Request[$Property] = @($Request[$Property] | Where-Object { $null -ne $_ })

		}

		$Body = $Request | ConvertTo-R1JsonBody -Depth 20 -EmptyArrayProperty $ArrayProperties

		if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", 'Save Object Model')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
