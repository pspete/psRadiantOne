# .ExternalHelp psRadiantOne-help.xml
function New-R1DirectoryAttribute {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 500)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$alias,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateLength(1, 1000)]
		[string]$oid,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('Enhanced Guide', 'Presentation Address', 'Facsimile Telephone Number', 'Printable String', 'Postal Address', 'Protocol Information', 'Guide', 'IA5 String syntax', 'Fax', 'Generalized Time syntax', 'URI', 'Octet String', 'DIT Content Rule Description syntax', 'String for containing OIDs', 'DITStructure Rule Description syntax', 'Other Mailbox', 'Certificate Pair', 'LDAP Syntax Description syntax', 'Country String', 'MHS OR Address', 'Matching Rule Description', 'Telex Number', 'Matching Rule Use Description', 'Delivery Method', 'Numeric String', 'Substring Assertion', 'Directory String syntax', 'Object Class Description syntax', 'DN - distinguished name', 'Name And Optional UID', 'Name Form Description', 'Telephone Number syntax', 'Teletex Terminal Identifier', 'Boolean - TRUE/FALSE', 'Certificate', 'Certificate List', 'Integer syntax - integral number', 'Supported Algorithm', 'JPEG', 'Attribute Type Description syntax', 'Binary - octet string', 'Bit String')]
		[string]$syntax,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$multiValued,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$operational,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isRequired,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$isHiddenInLogs,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$objectclass
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Schema -Path 'attributes'

		$Request = $PSBoundParameters | Get-Parameter

		if ($Request.Contains('alias')) {

			$Request['alias'] = @($Request['alias'])

		}

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($name, 'Add Attribute')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
