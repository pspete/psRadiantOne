---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1StoreProperty

## SYNOPSIS
Returns the properties of a directory store.

## SYNTAX

```
Get-R1StoreProperty [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the properties of the directory store mounted at the naming context node, including schema checking, the attributes which are indexed, sorted and encrypted, replication and push mode settings, and whether full text search, the changelog and asynchronous indexing are enabled.

## EXAMPLES

### Example 1
```powershell
Get-R1StoreProperty -dn 'o=companydirectory'
```

Returns the properties of a directory store at o=companydirectory.

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

### psRadiantOne.StoreProperties

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
