# .ExternalHelp psRadiantOne-help.xml
function Get-R1Cache {
	[CmdletBinding(DefaultParameterSetName = 'All')]
	[OutputType('psRadiantOne.Cache')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Dn'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('label')]
		[string]$dn,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'All'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$baseDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'caches'

		if ($PSCmdlet.ParameterSetName -eq 'Dn') {

			$Path = "$Path/$($dn | Get-EscapedString)"

		} elseif ($PSBoundParameters.ContainsKey('baseDn')) {

			#The API names the filter dn, which here would collide with the DN of a single cache
			$QueryString = @{ dn = $baseDn } | ConvertTo-QueryString

			$Path = "$Path`?$QueryString"

		}

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path $Path

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.Cache

		}

	}#process

	End { }#end

}
