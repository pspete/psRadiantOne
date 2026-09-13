# .ExternalHelp psRadiantOne-help.xml
function Close-R1DirectoryPagedSearch {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('cursor')]
		[string]$cookie
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ cookie = $cookie } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Browser -Path "directory_browser/paged_searches/close`?$Query"

		if ($PSCmdlet.ShouldProcess($cookie, 'Close Paged Search Session')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST

		}

	}#process

	End { }#end

}
