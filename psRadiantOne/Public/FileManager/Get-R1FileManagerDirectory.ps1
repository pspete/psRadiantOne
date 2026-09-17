# .ExternalHelp psRadiantOne-help.xml
function Get-R1FileManagerDirectory {
	[CmdletBinding()]
	[OutputType('psRadiantOne.Directory')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$path
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$RequestPath = 'file_manager/directories'

		$Query = $PSBoundParameters | Get-Parameter

		if ($Query.Count -gt 0) {

			$RequestPath = "$RequestPath`?$($Query | ConvertTo-QueryString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Settings -Path $RequestPath

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			#The API wraps the entries in an object which also carries uploadAllowed, the flag for the
			#directory listed. The entries are what a caller reads and pipes, so they are returned,
			#and the flag rides along on each of them.
			$Entries = if ($null -ne $Result.PSObject.Properties['entries']) { $Result.entries } else { $Result }

			foreach ($Entry in $Entries) {

				if ($null -ne $Result.PSObject.Properties['uploadAllowed']) {

					$Entry | Add-Member -MemberType NoteProperty -Name uploadAllowed -Value $Result.uploadAllowed -Force

				}

				$Entry | Add-CustomType -Type psRadiantOne.Directory

			}

		}

	}#process

	End { }#end

}
