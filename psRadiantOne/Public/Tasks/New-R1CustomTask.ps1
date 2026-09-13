# .ExternalHelp psRadiantOne-help.xml
function New-R1CustomTask {
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
		[string]$JavaClassPath,

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
		[string]$TaskPropertiesPath
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path 'tasks/experimental/custom'

		$ClassFile = Get-Item -Path $JavaClassPath
		$PropertiesFile = Get-Item -Path $TaskPropertiesPath

		$Form = ConvertTo-MultipartFormData -Field @{
			javaClass      = $ClassFile
			taskProperties = $PropertiesFile
		}

		if ($PSCmdlet.ShouldProcess($ClassFile.Name, 'Create Custom Task')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Form.Body -ContentType $Form.ContentType

		}

	}#process

	End { }#end

}
