# .ExternalHelp psRadiantOne-help.xml
function Set-R1DirectorySearchInfo {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$history,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[object[]]$tabs
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Browser -Path 'directory_browser/search/info'

		#Retrieve the stored info and send it back with the supplied values applied over it, so the
		#history or tabs left unspecified keep their current value.
		$Existing = Get-R1DirectorySearchInfo

		$Template = [ordered]@{
			history = @()
			tabs    = @()
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter) -Fallback $Existing

		foreach ($Collection in 'history', 'tabs') {

			$Request[$Collection] = @($Request[$Collection])

		}

		$Body = $Request | ConvertTo-R1JsonBody -EmptyArrayProperty history, tabs

		if ($PSCmdlet.ShouldProcess($Script:psRadiantOneSession.BaseURI, 'Save Directory Browser Search Info')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
