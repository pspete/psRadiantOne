# .ExternalHelp psRadiantOne-help.xml
function Test-R1InterceptionScriptCode {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ScriptCompilationResults')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 100000)]
		[string]$scriptContents,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$classname,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$filename
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path 'interception_scripts/code/compile'

		$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.ScriptCompilationResults

		}

	}#process

	End { }#end

}
