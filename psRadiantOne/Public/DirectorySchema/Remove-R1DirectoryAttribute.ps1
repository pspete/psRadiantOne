# .ExternalHelp psRadiantOne-help.xml
function Remove-R1DirectoryAttribute {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[Alias('name')]
		[string]$attribute
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Schema -Path "attributes/$($attribute | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($attribute, 'Delete Attribute')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method DELETE

		}

	}#process

	End { }#end

}
