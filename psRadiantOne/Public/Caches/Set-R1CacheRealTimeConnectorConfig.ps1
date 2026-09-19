# .ExternalHelp psRadiantOne-help.xml
function Set-R1CacheRealTimeConnectorConfig {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('label')]
		[string]$dn,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$connectorId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNullOrEmpty()]
		[string]$type,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[ValidateNotNull()]
		[System.Collections.IDictionary]$properties = @{ }
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Namespace -Path "caches/$($dn | Get-EscapedString)/refresh/real_time_connectors/$($connectorId | Get-EscapedString)/config"

		#Retrieve the current configuration. A connector which is not configured yet, or is moving to
		#another type, starts from the properties that type offers.
		$Existing = Get-R1CacheRealTimeConnectorConfig -dn $dn -connectorId $connectorId

		$ConnectorType = if ($PSBoundParameters.ContainsKey('type')) { $type } else { $Existing.type }

		if ([string]::IsNullOrEmpty($ConnectorType)) {

			throw "The connector $connectorId is not configured, so its type must be given"

		}

		if (($ConnectorType -eq $Existing.type) -and (@($Existing.properties).Count -gt 0)) {

			$Current = @($Existing.properties)

		} else {

			$Template = @(Get-R1CacheRealTimeConnectorType -dn $dn -connectorId $connectorId) | Where-Object { $_.name -eq $ConnectorType }

			if ($null -eq $Template) {

				throw "The connector $connectorId offers no type named $ConnectorType"

			}

			$Current = @($Template.properties)

		}

		$Known = @($Current | ForEach-Object { $_.name })

		foreach ($Name in $properties.Keys) {

			if ($Name -notin $Known) {

				throw "The $ConnectorType connector has no property named $Name. Its properties are $($Known -join ', ')"

			}

		}

		#Each property is sent back as it was read, with its value replaced where one is given. Every
		#value is a string, as the API returns and the control panel sends them.
		$Merged = foreach ($Property in $Current) {

			$Item = [ordered]@{}

			foreach ($Field in $Property.PSObject.Properties) {

				$Item[$Field.Name] = $Field.Value

			}

			if ($properties.Contains($Property.name)) {

				$Value = $properties[$Property.name]

				$Item['value'] = switch ($Value) {
					{ $PSItem -is [System.Security.SecureString] } { ConvertTo-InsecureString -SecureString $PSItem; break }
					{ $PSItem -is [bool] } { "$PSItem".ToLower(); break }
					default { "$PSItem" }
				}

			}

			$Item

		}

		#The configuration carries the log table password, so the body is sent as bytes
		$Body = [ordered]@{
			type       = $ConnectorType
			properties = @($Merged)
		} | ConvertTo-R1SecretBody -EmptyArrayProperty properties

		if ($PSCmdlet.ShouldProcess("$dn ($connectorId)", "Configure $ConnectorType Real Time Connector")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
