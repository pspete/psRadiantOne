# .ExternalHelp psRadiantOne-help.xml
function Get-R1DirectoryEntry {
	[CmdletBinding(DefaultParameterSetName = 'Root')]
	[OutputType('psRadiantOne.Entry')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Dn'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Dn'
		)]
		[ValidateLength(0, 5000)]
		[string]$filter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Dn'
		)]
		[ValidateSet('BASE', 'ONE', 'SUB')]
		[string]$scope,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$attributes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Dn'
		)]
		[ValidateRange(0, 100000)]
		[int]$pageSize,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Dn'
		)]
		[bool]$hierarchical
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = $PSBoundParameters | Get-Parameter -ParametersToRemove dn

		#The API expects the lowercase JSON spelling of a boolean, not PowerShell's
		if ($Query.ContainsKey('hierarchical')) {

			$Query['hierarchical'] = "$($Query['hierarchical'])".ToLowerInvariant()

		}

		if ($PSCmdlet.ParameterSetName -eq 'Dn') {

			$Path = "directory_browser/$($dn | Get-EscapedString)"

		} else {

			$Path = 'directory_browser'

		}

		do {

			$QueryString = $Query | ConvertTo-QueryString

			$RequestPath = $Path

			if (-not ([string]::IsNullOrEmpty($QueryString))) {

				$RequestPath = "$Path`?$QueryString"

			}

			$URI = Resolve-R1ServiceUrl -Service Browser -Path $RequestPath

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

			if ($null -ne $Result.nodes) {

				$Result.nodes | Add-CustomType -Type psRadiantOne.Entry

			}

			#A cursor is returned only while further pages remain
			$Cursor = $Result.cursor

			if (-not ([string]::IsNullOrEmpty($Cursor))) {

				$Query['cursor'] = $Cursor

			}

		} while (-not ([string]::IsNullOrEmpty($Cursor)))

	}#process

	End { }#end

}
