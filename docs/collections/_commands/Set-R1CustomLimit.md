---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1CustomLimit

## SYNOPSIS
Replaces the custom limits.

## SYNTAX

```
Set-R1CustomLimit [-limits] <Hashtable[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces the complete collection of custom limits.

The API takes the whole collection, so any limit not included is removed. Retrieve the current
limits with Get-R1CustomLimit first if you mean to add to them rather than replace them.

## EXAMPLES

### Example 1
```powershell
Set-R1CustomLimit -limits @{ dnType = 'sub-tree'; dn = 'dc=example,dc=com'; maxConnection = 50 }
```

Replaces the custom limits with a single subtree limit.

### Example 2
```powershell
Set-R1CustomLimit -limits @()
```

Removes every custom limit.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limits
The complete collection of custom limits, each a hashtable with a dnType of sub-tree, group, anonymousUsers or authenticatedUsers, an optional dn, and the maxConnection, sizeLimit, idleTimeLimit and timeLimit to apply.

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
