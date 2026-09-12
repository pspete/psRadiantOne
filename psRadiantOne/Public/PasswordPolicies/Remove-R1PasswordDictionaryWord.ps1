# .ExternalHelp psRadiantOne-help.xml
function Remove-R1PasswordDictionaryWord {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$words
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		#Deletion is a POST to a dedicated path, not a DELETE
		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'password_policies/dictionary/delete'

		$Body = ConvertTo-R1JsonBody -Body @{ words = @($words) }

		if ($PSCmdlet.ShouldProcess(($words -join ', '), 'Remove Password Dictionary Words')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
