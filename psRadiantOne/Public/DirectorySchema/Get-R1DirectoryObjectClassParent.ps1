# .ExternalHelp psRadiantOne-help.xml
function Get-R1DirectoryObjectClassParent {
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[string]$objectClass
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Schema -Path "object_classes/$($objectClass | Get-EscapedString)/parent_object_classes"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result

		}

	}#process

	End { }#end

}
