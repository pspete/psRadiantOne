# .ExternalHelp psRadiantOne-help.xml
function New-R1JoinProfile {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
	[OutputType('psRadiantOne.JoinProfile')]
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
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNull()]
		[object]$joinInputSource,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 10000)]
		[string]$joinCondition,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$returnAttributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$returnAllAttributes
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/object_builder/primary_objects/$($primaryObject | Get-EscapedString)/objects/join_profiles"

		$Request = [ordered]@{
			name            = $name
			joinInputSource = $joinInputSource
			joinCondition   = $joinCondition
		}

		#Each attribute returned keeps its own name, as the control panel sends it
		$Request['returnAttributes'] = @($returnAttributes | Where-Object { $PSItem } | ForEach-Object {
				[ordered]@{ name = $PSItem; virtualName = $PSItem; tags = @() }
			})

		if ($PSBoundParameters.ContainsKey('returnAllAttributes')) {

			$Request['returnAllAttributes'] = $returnAllAttributes

		}

		$Body = $Request | ConvertTo-R1JsonBody -Depth 20 -EmptyArrayProperty returnAttributes, tags

		if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", "Build Join Profile '$name'")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.JoinProfile

			}

		}

	}#process

	End { }#end

}
