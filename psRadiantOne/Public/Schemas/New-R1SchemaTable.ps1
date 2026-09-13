# .ExternalHelp psRadiantOne-help.xml
function New-R1SchemaTable {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType('psRadiantOne.Table')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('schema')]
		[string]$schemaName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$objectClass,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$baseTable,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$candidateKeyName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$candidateKeys,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$owner,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$primaryKeys,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isTable
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Catalog -Path "schemas/$($schemaName | Get-EscapedString)/tables"

		$Request = $PSBoundParameters | Get-Parameter -ParametersToRemove schemaName

		foreach ($Collection in 'candidateKeys', 'primaryKeys') {

			if ($Request.Contains($Collection)) {

				$Request[$Collection] = @($Request[$Collection])

			}

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, 'Create Table View')) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.Table

			}

		}

	}#process

	End { }#end

}
