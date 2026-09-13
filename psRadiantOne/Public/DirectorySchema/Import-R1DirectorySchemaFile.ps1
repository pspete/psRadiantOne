# .ExternalHelp psRadiantOne-help.xml
function Import-R1DirectorySchemaFile {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Local')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Local'
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
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Local'
		)]
		[bool]$isOverride,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Server'
		)]
		[ValidatePattern('^[\w,\s-]+\.(ldif|ldifz|LDIF|LDIFZ)$')]
		[string]$file,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Server'
		)]
		[ValidateSet('ADD', 'ADD_OR_OVERRIDE')]
		[string]$addBehavior
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Schema -Path 'files/import'

		if ($PSCmdlet.ParameterSetName -eq 'Local') {

			$UploadFile = Get-Item -Path $Path

			$Field = @{ file = $UploadFile }

			if ($PSBoundParameters.ContainsKey('isOverride')) {

				$Field['isOverride'] = "$isOverride".ToLowerInvariant()

			}

			$Form = ConvertTo-MultipartFormData -Field $Field

			$Target = $UploadFile.Name
			$Body = $Form.Body
			$ContentType = $Form.ContentType

		} else {

			$Target = $file
			$Body = $PSBoundParameters | Get-Parameter | ConvertTo-R1JsonBody
			$ContentType = 'application/json'

		}

		if ($PSCmdlet.ShouldProcess($Target, 'Import Directory Schema File')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body -ContentType $ContentType

		}

	}#process

	End { }#end

}
