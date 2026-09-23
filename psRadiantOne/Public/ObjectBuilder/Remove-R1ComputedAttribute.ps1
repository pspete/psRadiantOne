# .ExternalHelp psRadiantOne-help.xml
function Remove-R1ComputedAttribute {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
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
		[ValidateNotNullOrEmpty()]
		[string]$primaryObject,

		[parameter(
			Mandatory = $true,
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

		if (-not ($Object.finalOutput.computedAttributes | Where-Object { $_.name -eq $name })) {

			throw "No computed attribute named '$name' on $dn ($primaryObject)."

		}

		$Object.finalOutput.computedAttributes = @(
			$Object.finalOutput.computedAttributes | Where-Object { $_.name -ne $name }
		)

		$Attribute = $Object.finalOutput.attributes | Where-Object { $_.virtualName -eq $name }

		if ($null -ne $Attribute) {

			$Origin = @($Attribute.origin | Where-Object { $_ -ne 'computed' })

			if ($Origin.Count -eq 0) {

				#Computed was the only origin, so the attribute exists for no other reason
				$Object.finalOutput.attributes = @(
					$Object.finalOutput.attributes | Where-Object { $_.virtualName -ne $name }
				)

			} else {

				$Attribute.origin = $Origin
				$Attribute.precedentAttributes = @(
					$Attribute.precedentAttributes | Where-Object { $_.origin -ne 'computed' }
				)

			}

		}

		if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", "Remove Computed Attribute '$name'")) {

			Set-R1SecondaryObject -dn $dn -primaryObject $primaryObject -finalOutput $Object.finalOutput -Confirm:$false

		}

	}#process

	End { }#end

}
