# .ExternalHelp psRadiantOne-help.xml
function Get-R1NamingContextLinkParameterString {
	[CmdletBinding()]
	[OutputType('System.String')]
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
		[Alias('name')]
		[string]$linkParameterAttrName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('attrType')]
		[string]$linkParameterAttrType
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$QueryString = $PSBoundParameters | Get-Parameter -ParametersToKeep linkParameterAttrName, linkParameterAttrType | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/link/parameters/parameter_string`?$QueryString"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result.linkParametersString

		}

	}#process

	End { }#end

}
