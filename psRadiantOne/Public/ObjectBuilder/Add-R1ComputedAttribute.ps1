# .ExternalHelp psRadiantOne-help.xml
function Add-R1ComputedAttribute {
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
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$expression,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('LOWEST', 'LOW', 'NORMAL', 'HIGH', 'HIGHEST')]
		[string]$priority = 'NORMAL',

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$active = $true
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$Object = Get-R1SecondaryObject -dn $dn -primaryObject $primaryObject

		if ($Object.finalOutput.computedAttributes | Where-Object { $_.name -eq $name }) {

			throw "A computed attribute named '$name' already exists on $dn ($primaryObject). Use Set-R1ComputedAttribute to change it."

		}

		$Attribute = $Object.finalOutput.attributes | Where-Object { $_.virtualName -eq $name }

		if ($null -eq $Attribute) {

			#The attribute does not exist yet, so the whole descriptor is created with computed as
			#its only origin
			$Object.finalOutput.attributes = @($Object.finalOutput.attributes) + [pscustomobject]@{
				virtualName         = $name
				origin              = @('computed')
				tags                = @()
				isHidden            = $false
				canModifyHidden     = $true
				precedentAttributes = @((Get-ComputedPrecedent -Name $name))
			}

		} else {

			#The computed origin and its precedent are appended: the server drops the computed
			#attribute outright if the precedent is sent ahead of the backend ones
			$Attribute.origin = @(@($Attribute.origin | Where-Object { $_ -ne 'computed' }) + 'computed')
			$Attribute.precedentAttributes = @(
				@($Attribute.precedentAttributes | Where-Object { $_.origin -ne 'computed' }) +
				(Get-ComputedPrecedent -Name $name)
			)

		}

		$Object.finalOutput.computedAttributes = @($Object.finalOutput.computedAttributes) +
			[pscustomobject]@{ active = $active; name = $name; expression = $expression }

		if ($PSCmdlet.ShouldProcess("$dn ($primaryObject)", "Add Computed Attribute '$name'")) {

			Set-R1SecondaryObject -dn $dn -primaryObject $primaryObject -finalOutput $Object.finalOutput -Confirm:$false

			if ($priority -ne 'NORMAL') {

				#A priority change cannot share a request with a computedAttributes write: the
				#server accepts it and silently discards the computed attribute
				Set-R1ComputedAttribute -dn $dn -primaryObject $primaryObject -name $name -priority $priority -Confirm:$false

			}

		}

	}#process

	End { }#end

}
