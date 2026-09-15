# .ExternalHelp psRadiantOne-help.xml
function Get-R1LdapDataPreview {
	[CmdletBinding()]
	[OutputType('psRadiantOne.PreviewBaseDnResponse')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('name')]
		[string]$dataSourceName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$baseDn
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = 'data_preview/ldap'

		if ($PSBoundParameters.ContainsKey('baseDn')) {

			$Path = "$Path/$($baseDn | Get-EscapedString)"

		}

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path $Path

		#The request body is one of two shapes and existingDataSource is the discriminator the API
		#picks between them with. Without it the request is rejected as unconvertible.
		$Body = [ordered]@{
			existingDataSource = $true
			dataSourceName     = $dataSourceName
		} | ConvertTo-R1SecretBody

		$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		if ($null -ne $Result) {

			$Result | Add-CustomType -Type psRadiantOne.PreviewBaseDnResponse

		}

	}#process

	End { }#end

}
