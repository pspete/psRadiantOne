---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DirectoryObjectClassParent

## SYNOPSIS
Returns the parent object classes of an object class.

## SYNTAX

```
Get-R1DirectoryObjectClassParent [-objectClass] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the object classes the named object class inherits from.

## EXAMPLES

### Example 1
```powershell
Get-R1DirectoryObjectClassParent -objectClass 'inetOrgPerson'
```

Returns the object classes inetOrgPerson inherits from.

## PARAMETERS

### -objectClass
The name of the object class.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DirectoryObjectClass](Get-R1DirectoryObjectClass)
