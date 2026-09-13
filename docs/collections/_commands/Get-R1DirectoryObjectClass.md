---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DirectoryObjectClass

## SYNOPSIS
Returns the object classes in the directory schema.

## SYNTAX

### All (Default)
```
Get-R1DirectoryObjectClass [<CommonParameters>]
```

### ObjectClass
```
Get-R1DirectoryObjectClass -objectClass <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the name of every object class in the LDAP schema, or the full definition of a single
object class when one is named.

## EXAMPLES

### Example 1
```powershell
Get-R1DirectoryObjectClass
```

Returns the name of every object class in the schema.

### Example 2
```powershell
Get-R1DirectoryObjectClass -objectClass 'inetOrgPerson'
```

Returns the full definition of inetOrgPerson.

### Example 3
```powershell
(Get-R1DirectoryObjectClass -objectClass 'inetOrgPerson').requiredAttrs.name
```

Returns the names of the attributes an inetOrgPerson entry must carry.

## PARAMETERS

### -objectClass
The name of the object class.

```yaml
Type: String
Parameter Sets: ObjectClass
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.ObjectClass

## NOTES

## RELATED LINKS

[New-R1DirectoryObjectClass](New-R1DirectoryObjectClass)

[Set-R1DirectoryObjectClass](Set-R1DirectoryObjectClass)

[Remove-R1DirectoryObjectClass](Remove-R1DirectoryObjectClass)

[Get-R1DirectoryObjectClassParent](Get-R1DirectoryObjectClassParent)
