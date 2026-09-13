# .ExternalHelp psRadiantOne-help.xml
function Get-R1FileContent {
	[CmdletBinding()]
	[OutputType('psRadiantOne.FileContents')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$file
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Query = @{ file = $file } | ConvertTo-QueryString

		$URI = Resolve-R1ServiceUrl -Service Settings -Path "file_manager/files/contents`?$Query"

		$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.FileContents

		}

	}#process

	End { }#end

}
