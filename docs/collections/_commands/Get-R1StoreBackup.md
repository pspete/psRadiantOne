---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1StoreBackup

## SYNOPSIS
Returns the backups of a directory store.

## SYNTAX

```
Get-R1StoreBackup [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the backups taken of the directory store mounted at the naming context node. Nothing is returned for a store with no backups.

## EXAMPLES

### Example 1
```powershell
Get-R1StoreBackup -dn 'o=companydirectory'
```

Returns the backups of a directory store at o=companydirectory.

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

### psRadiantOne.StoreBackup

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
