# .ExternalHelp psRadiantOne-help.xml
function Import-R1DataSource {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateScript({
				if (-not (Test-Path -Path $PSItem -PathType Leaf)) {

					throw "File not found: $PSItem"

				}
				$true
			})]
		[Alias('FullName')]
		[string]$Path,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$overrideExisting,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$performOpOnSchemas,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$crossEnvironment,

		[parameter(Mandatory = $false)]
		[switch]$Xml
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Endpoint = if ($Xml) { 'data_sources/import_xml' } else { 'data_sources/import' }

		#The xml import defines only overrideExisting; the others belong to the zip import alone. Any
		#left unspecified is left out, so the API applies its own default.
		$Supported = if ($Xml) { , 'overrideExisting' } else { 'overrideExisting', 'performOpOnSchemas', 'crossEnvironment' }

		$Query = [ordered]@{ }

		foreach ($Option in $Supported) {

			if ($PSBoundParameters.ContainsKey($Option)) {

				$Query[$Option] = "$($PSBoundParameters[$Option])".ToLower()

			}

		}

		if ($Query.Count -gt 0) {

			$Endpoint = "$Endpoint`?$($Query | ConvertTo-QueryString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Endpoint

		$UploadFile = Get-Item -Path $Path

		$Form = ConvertTo-MultipartFormData -Field @{ file = $UploadFile }

		if ($PSCmdlet.ShouldProcess($UploadFile.Name, 'Import Data Source')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

		}

	}#process

	End { }#end

}
