# .ExternalHelp psRadiantOne-help.xml
function Get-R1FIDUser {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.FIDUser')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Username'
		)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[a-zA-Z0-9_-]+$')]
		[string]$username,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[ValidateLength(0, 1000)]
		[string]$searchFilter,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[ValidateRange(0, 10000)]
		[int]$pageSize
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($PSCmdlet.ParameterSetName -eq 'Username') {

			$URI = Resolve-R1ServiceUrl -Service Auth -Path "users/$($username | Get-EscapedString)"

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.FIDUser

			}

		} else {

			$Query = $PSBoundParameters | Get-Parameter

			do {

				$QueryString = $Query | ConvertTo-QueryString

				$Path = 'users'

				if (-not ([string]::IsNullOrEmpty($QueryString))) {

					$Path = "$Path`?$QueryString"

				}

				$URI = Resolve-R1ServiceUrl -Service Auth -Path $Path

				$Result = Invoke-R1RestMethod -Uri $URI -Method GET

				if ($null -ne $Result.users) {

					$Result.users | Add-CustomType -Type psRadiantOne.FIDUser

				}

				#The next page is reported as a complete url; reissue its cursor against the session base url
				$NextCursor = $null

				if (-not ([string]::IsNullOrEmpty($Result.next))) {

					$NextCursor = [regex]::Match($Result.next, 'cursor=([^&]+)').Groups[1].Value

				}

				if (-not ([string]::IsNullOrEmpty($NextCursor))) {

					$Query['cursor'] = [System.Uri]::UnescapeDataString($NextCursor)

				}

			} while (-not ([string]::IsNullOrEmpty($NextCursor)))

		}

	}#process

	End { }#end

}
