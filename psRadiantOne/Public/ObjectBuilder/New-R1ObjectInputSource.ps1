# .ExternalHelp psRadiantOne-help.xml
function New-R1ObjectInputSource {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
	[OutputType('psRadiantOne.InputSource')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$primaryObject,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Namespace'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$targetBaseDn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Namespace'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$objectClass,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Namespace'
		)]
		[ValidateSet('BASE', 'ONE', 'SUB')]
		[string]$scope,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Namespace'
		)]
		[ValidateRange(0, 100000)]
		[int]$sizeLimit,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'DataSourceSchema'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dataSource,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'DataSourceSchema'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$schema,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'DataSourceSchema'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$object
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Path = "naming_contexts/$($dn | Get-EscapedString)/object_builder/primary_objects/$($primaryObject | Get-EscapedString)/objects/input_sources/add"

		switch ($PSCmdlet.ParameterSetName) {

			'Namespace' {

				$Path = "$Path/namespace"

				$Request = [ordered]@{
					targetBaseDn = $targetBaseDn
					objectClass  = $objectClass
					scope        = $scope
				}

				#The control panel sends the size limit as a string
				if ($PSBoundParameters.ContainsKey('sizeLimit')) {

					$Request['sizeLimit'] = "$sizeLimit"

				}

				$Target = "$objectClass under $targetBaseDn"

			}

			'DataSourceSchema' {

				$Path = "$Path/data_source_schema"

				$Request = [ordered]@{
					dataSource = $dataSource
					schema     = $schema
					object     = $object
				}

				$Target = "$object from $dataSource"

			}

		}

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path $Path

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", "Build Input Source for $Target")) {

			$Result = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $Result) {

				$Result | Add-CustomType -Type psRadiantOne.InputSource

			}

		}

	}#process

	End { }#end

}
