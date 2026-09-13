# .ExternalHelp psRadiantOne-help.xml
function Remove-R1DirectoryObjectClass {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
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

		$URI = Resolve-R1ServiceUrl -Service Schema -Path "object_classes/$($objectClass | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($objectClass, 'Delete Object Class')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
