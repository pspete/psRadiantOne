# .ExternalHelp psRadiantOne-help.xml
function New-R1NamingContextContent {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
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
		[ValidateLength(1, 500)]
		[string]$relationshipObjectDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isQuoteTableNames = $false,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isQuoteColumnNames = $false,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isRelatedObjectsOnly = $false,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$schema
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "naming_contexts/$($dn | Get-EscapedString)/add_content"

		#The flags are always sent, as the control panel sends them: the API otherwise defaults
		#isRelatedObjectsOnly to true
		$Request = [ordered]@{
			relationshipObjectDn = $relationshipObjectDn
			isQuoteColumnNames   = $isQuoteColumnNames
			isQuoteTableNames    = $isQuoteTableNames
		}

		if ($PSBoundParameters.ContainsKey('schema')) {

			$Request['schema'] = $schema

		}

		$Request['isRelatedObjectsOnly'] = $isRelatedObjectsOnly

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($dn, 'Add Child Content')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
