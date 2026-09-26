function Get-R1ObjectClassAttributeSet {
	<#
	.SYNOPSIS
	Gets the object classes and attributes an entry of the given object classes carries.

	.DESCRIPTION
	The schema lists only the attributes an object class defines itself; those of its superclasses are
	listed against them. Each object class given is followed up through its superclasses, and the
	attributes of every class reached are combined, an attribute being required when any class
	requires it.

	Each object class read from the schema is held in the module scope for the session's BaseURI, as
	dynamic parameters are rebuilt on every tab completion.

	.PARAMETER objectClass
	The object classes of the entry, structural and auxiliary.

	.EXAMPLE
	Get-R1ObjectClassAttributeSet -objectClass inetOrgPerson

	Outputs the object classes top, person, organizationalPerson and inetOrgPerson, and the attributes
	of all four.

	.OUTPUTS
	System.Management.Automation.PSCustomObject
	#>
	[CmdletBinding()]
	[OutputType('System.Management.Automation.PSCustomObject')]
	param(
		[parameter(Mandatory = $true)]
		[string[]]$objectClass
	)

	Process {

		$Classes = [System.Collections.Generic.List[string]]::new()
		$Attributes = [ordered]@{ }

		foreach ($Class in $objectClass) {

			$Chain = [System.Collections.Generic.List[string]]::new()

			while ((-not [string]::IsNullOrEmpty($Class)) -and ($Chain -notcontains $Class) -and ($Classes -notcontains $Class)) {

				$Key = "$($Script:psRadiantOneSession.BaseURI)|$Class"

				if (-not $Script:psRadiantOneObjectClassCache.ContainsKey($Key)) {

					$Schema = Get-R1DirectoryObjectClass -objectClass $Class

					if ($null -eq $Schema) { break }

					$Script:psRadiantOneObjectClassCache[$Key] = $Schema

				}

				$Schema = $Script:psRadiantOneObjectClassCache[$Key]

				$Chain.Insert(0, $Schema.objectClass)

				foreach ($Attribute in @($Schema.requiredAttrs) + @($Schema.optionalAttrs)) {

					if ($null -eq $Attribute) { continue }

					$IsRequired = @($Schema.requiredAttrs) -contains $Attribute

					if ($Attributes.Contains($Attribute.name)) {

						if ($IsRequired) { $Attributes[$Attribute.name].isRequired = $true }

					} else {

						$Attributes[$Attribute.name] = [pscustomobject]@{
							name        = $Attribute.name
							alias       = $Attribute.alias
							multiValued = [bool]$Attribute.multiValued
							isRequired  = $IsRequired
						}

					}

				}

				$Class = $Schema.superClass

			}

			$Classes.AddRange($Chain)

		}

		[pscustomobject]@{
			objectClass = $Classes.ToArray()
			attributes  = @($Attributes.Values)
		}

	}

}
