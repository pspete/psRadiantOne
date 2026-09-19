---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextReplication

## SYNOPSIS
Returns whether replication is started for a naming context node.

## SYNTAX

```
Get-R1NamingContextReplication [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns true where replication is started for the store or cached naming context node at the DN, and false where it is stopped.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextReplication -dn 'o=companydirectory'
```

Returns whether replication is started for a naming context node at o=companydirectory.

## PARAMETERS

### -dn
The DN of the naming context node.

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

### System.Boolean

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
