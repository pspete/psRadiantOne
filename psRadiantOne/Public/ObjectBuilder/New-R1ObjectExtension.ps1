# .ExternalHelp psRadiantOne-help.xml
function New-R1ObjectExtension {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
	[OutputType('psRadiantOne.InputSource')]
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
		[string[]]$attributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$objectClass = 'extensibleobject'
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/object_builder/primary_objects/$($primaryObject | Get-EscapedString)/objects/extensions"

		$Body = [ordered]@{
			objectClass = $objectClass
			attributes  = @($attributes | ForEach-Object { [ordered]@{ name = $PSItem; isChecked = $true } })
		} | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", "Build $objectClass Extension")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.InputSource

			}

		}

	}#process

	End { }#end

}
