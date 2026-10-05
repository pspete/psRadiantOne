# .ExternalHelp psRadiantOne-help.xml
function New-R1DirectoryEntry {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Attributes')]
	[OutputType([void])]
	param(
		[parameter(
			Position = 0,
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Position = 1,
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Attributes'
		)]
		[ValidateNotNullOrEmpty()]
		[object[]]$attributes,

		[parameter(
			Position = 2,
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$rdn,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'ObjectClass'
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$objectClass
	)

	DynamicParam {

		if (($PSBoundParameters.ContainsKey('objectClass')) -and (-not [string]::IsNullOrEmpty($Script:psRadiantOneSession.Token))) {

			try {

				$AttributeSet = Get-R1ObjectClassAttributeSet -objectClass $PSBoundParameters['objectClass'] -ErrorAction Stop

			} catch {

				return

			}

			$Taken = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
			@(
				'dn', 'attributes', 'objectClass', 'rdn'
				[System.Management.Automation.PSCmdlet]::CommonParameters
				[System.Management.Automation.PSCmdlet]::OptionalCommonParameters
			) | ForEach-Object { [void]$Taken.Add($PSItem) }

			$Dictionary = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()

			foreach ($Attribute in ($AttributeSet.attributes | Sort-Object -Property @{ Expression = 'isRequired'; Descending = $true }, name)) {

				if (-not $Taken.Add($Attribute.name)) { continue }

				$Collection = [System.Collections.ObjectModel.Collection[System.Attribute]]::new()
				$Collection.Add([System.Management.Automation.ParameterAttribute]@{
						ParameterSetName                = 'ObjectClass'
						Mandatory                       = $Attribute.isRequired
						ValueFromPipelineByPropertyName = $true
					})

				$Aliases = @("$($Attribute.alias)" -split '\s+' | Where-Object {
						$PSItem -and ($AttributeSet.attributes.name -notcontains $PSItem) -and $Taken.Add($PSItem)
					})

				if ($Aliases.Count -gt 0) {

					$Collection.Add([System.Management.Automation.AliasAttribute]::new([string[]]$Aliases))

				}

				$Type = if ($Attribute.multiValued) { [string[]] } else { [string] }

				$Dictionary.Add($Attribute.name, [System.Management.Automation.RuntimeDefinedParameter]::new($Attribute.name, $Type, $Collection))

			}

			$Dictionary

		}

	}

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Browser -Path 'directory_browser'

		$Entry = $attributes

		if ($PSCmdlet.ParameterSetName -eq 'ObjectClass') {

			$Entry = $PSBoundParameters | Get-Parameter -ParametersToRemove dn, objectClass, rdn
			$Entry['objectClass'] = (Get-R1ObjectClassAttributeSet -objectClass $objectClass).objectClass

		}

		$Request = $PSBoundParameters | Get-Parameter -ParametersToKeep dn, rdn

		$Request['attributes'] = @(ConvertTo-R1NameValueList -InputObject $Entry -ValueName values -MultiValued)

		$Body = $Request | ConvertTo-R1SecretBody

		if ($PSCmdlet.ShouldProcess($dn, 'Add Directory Entry')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
