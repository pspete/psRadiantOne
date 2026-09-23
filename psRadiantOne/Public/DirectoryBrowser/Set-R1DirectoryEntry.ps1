# .ExternalHelp psRadiantOne-help.xml
function Set-R1DirectoryEntry {
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Attributes')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			Position = 0
		)]
		[ValidateNotNullOrEmpty()]
		[string]$dn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Attributes'
		)]
		[System.Collections.IDictionary]$add,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Attributes'
		)]
		[System.Collections.IDictionary]$delete,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Attributes'
		)]
		[System.Collections.IDictionary]$replace,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'Modifications',
			Position = 1
		)]
		[ValidateNotNullOrEmpty()]
		[object[]]$modifications
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Browser -Path "directory_browser/$($dn | Get-EscapedString)/ldap_modify"

		$Modification = if ($PSCmdlet.ParameterSetName -eq 'Modifications') {

			@($modifications)

		} else {

			$ByType = [ordered]@{ DELETE = $delete; ADD = $add; REPLACE = $replace }

			foreach ($Type in $ByType.Keys) {

				if ($ByType[$Type].Count -gt 0) {

					[ordered]@{
						modifyType = $Type
						attributes = @(ConvertTo-R1NameValueList -InputObject $ByType[$Type] -ValueName values -MultiValued)
					}

				}

			}

		}

		$Modification = @($Modification)

		if ($Modification.Count -eq 0) {

			throw 'No modifications supplied. Specify at least one attribute with -add, -delete or -replace.'

		}

		$Body = ConvertTo-R1SecretBody -InputObject $Modification

		if ($PSCmdlet.ShouldProcess($dn, "Modify Directory Entry ($($Modification.Count))")) {

			$null = Invoke-R1RestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	End { }#end

}
