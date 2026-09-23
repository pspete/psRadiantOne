# .ExternalHelp psRadiantOne-help.xml
function Set-R1ComputedAttribute {
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
		[ValidateNotNullOrEmpty()]
		[string]$primaryObject,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$expression,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('LOWEST', 'LOW', 'NORMAL', 'HIGH', 'HIGHEST')]
		[string]$priority
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Change = @('expression', 'active', 'priority') | Where-Object { $PSBoundParameters.ContainsKey($_) }

		if (-not $Change) {

			throw 'Specify at least one of -expression, -active or -priority.'

		}

		$Object = Get-R1SecondaryObject -dn $dn -primaryObject $primaryObject

		$ComputedAttribute = $Object.finalOutput.computedAttributes | Where-Object { $_.name -eq $name }

		if ($null -eq $ComputedAttribute) {

			throw "No computed attribute named '$name' on $dn ($primaryObject). Use Add-R1ComputedAttribute to create it."
		}

		#Attribute names are matched without regard to case, so the name the descriptor carries is
		#used in preference to the one supplied
		$Descriptor = $Object.finalOutput.attributes | Where-Object { $_.virtualName -eq $name }

		if ($null -ne $Descriptor) { $name = $Descriptor.virtualName }

		if ($PSBoundParameters.ContainsKey('expression') -or $PSBoundParameters.ContainsKey('active')) {

			if ($PSBoundParameters.ContainsKey('expression')) { $ComputedAttribute.expression = $expression }
			if ($PSBoundParameters.ContainsKey('active')) { $ComputedAttribute.active = $active }

			$ComputedAttribute.name = $name

			if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", "Set Computed Attribute '$name'")) {

				Set-R1SecondaryObject -dn $dn -primaryObject $primaryObject -finalOutput $Object.finalOutput -Confirm:$false

			}

		}

		if ($PSBoundParameters.ContainsKey('priority')) {

			#The priority is saved on its own: a changed priority sent alongside an edited
			#computedAttributes entry leaves the server with neither
			$Object = Get-R1SecondaryObject -dn $dn -primaryObject $primaryObject

			$Attribute = $Object.finalOutput.attributes | Where-Object { $_.virtualName -eq $name }
			$Precedent = $Attribute.precedentAttributes | Where-Object { $_.origin -eq 'computed' }

			if ($null -eq $Precedent) {

				throw "The attribute '$name' on $dn ($primaryObject) has no computed precedent to set a priority on."

			}

			$Precedent.priority = $priority
			$Precedent.name = $Attribute.virtualName

			if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", "Set Computed Attribute '$name' Priority")) {

				Set-R1SecondaryObject -dn $dn -primaryObject $primaryObject -finalOutput $Object.finalOutput -Confirm:$false

			}

		}

	}#process

	End { }#end

}
