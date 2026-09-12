# .ExternalHelp psRadiantOne-help.xml
function Set-R1Feature {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$flagId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$value
	)

	Begin {

		Assert-R1Session -RequireToken

		#The endpoint replaces the whole collection, so every flag is collected and sent together
		$Changes = @{ }

	}#begin

	Process {

		$Changes[$flagId] = $value

	}#process

	End {

		if ($Changes.Count -eq 0) { return }

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'features'

		#Retrieve every flag and apply the requested changes over them, so the flags which were not
		#named keep their current value rather than being dropped from the collection.
		$Existing = @(Get-R1Feature)

		$Request = foreach ($Flag in $Existing) {

			$Value = if ($Changes.ContainsKey($Flag.flagId)) { $Changes[$Flag.flagId] } else { $Flag.value }

			[ordered]@{
				flagId = $Flag.flagId
				value  = $Value
			}

		}

		$Unknown = $Changes.Keys | Where-Object { $PSItem -notin $Existing.flagId }

		if ($Unknown) {

			throw "No such feature flag: $($Unknown -join ', ')"

		}

		$Body = ConvertTo-R1JsonBody -Body @($Request)

		if ($PSCmdlet.ShouldProcess(($Changes.Keys -join ', '), 'Update Feature Flags')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#end

}
