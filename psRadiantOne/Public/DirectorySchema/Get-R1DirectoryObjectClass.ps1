# .ExternalHelp psRadiantOne-help.xml
function Get-R1DirectoryObjectClass {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.ObjectClass')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'ObjectClass'
		)]
		[ValidateLength(1, 500)]
		[string]$objectClass
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'ObjectClass') {

			$URI = Resolve-R1ServiceUrl -Service Schema -Path "object_classes/$($objectClass | Get-EscapedString)"

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.ObjectClass

			}

		} else {

			$URI = Resolve-R1ServiceUrl -Service Schema -Path 'object_classes'

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result) {

				$Result

			}

		}

	}#process

	End { }#end

}
