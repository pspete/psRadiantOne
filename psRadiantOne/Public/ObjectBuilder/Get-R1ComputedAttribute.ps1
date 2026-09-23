# .ExternalHelp psRadiantOne-help.xml
function Get-R1ComputedAttribute {
	[CmdletBinding()]
	[OutputType('psRadiantOne.ComputedAttribute')]
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
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Object = Get-R1SecondaryObject -dn $dn -primaryObject $primaryObject

		$ComputedAttributes = @($Object.finalOutput.computedAttributes)

		if ($PSBoundParameters.ContainsKey('name')) {

			$ComputedAttributes = @($ComputedAttributes | Where-Object { $_.name -eq $name })

		}

		foreach ($ComputedAttribute in $ComputedAttributes) {

			#A computed attribute is only presented if the matching attributes entry carries the
			#computed origin, so report the descriptor alongside the expression
			$Attribute = $Object.finalOutput.attributes |
				Where-Object { $_.virtualName -eq $ComputedAttribute.name }

			$Precedent = $Attribute.precedentAttributes | Where-Object { $_.origin -eq 'computed' }

			[pscustomobject]@{
				dn            = $dn
				primaryObject = $primaryObject
				name          = $ComputedAttribute.name
				active        = $ComputedAttribute.active
				expression    = $ComputedAttribute.expression
				priority      = $Precedent.priority
				origin        = $Attribute.origin
			} | Add-CustomType -Type psRadiantOne.ComputedAttribute

		}

	}#process

	End { }#end

}
