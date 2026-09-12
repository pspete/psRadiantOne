---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextChild

## SYNOPSIS
Returns the child nodes of a naming context.

## SYNTAX

```
Get-R1NamingContextChild [-dn] <String> [[-typeFilter] <String>] [[-limit] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns the nodes directly beneath the naming context node identified by its DN.

The pages of the API are followed, so every child node is returned rather than only the first page.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextChild -dn 'o=vds'
```

Returns the child nodes of o=vds.

### Example 2
```powershell
Get-R1NamingContextChild -dn 'o=vds' -typeFilter 'OFFLINE'
```

Returns the child nodes of o=vds which are offline.

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

### -typeFilter
Returns only nodes of the given type.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ACTIVE, OFFLINE, CACHE_NO_REFRESH, CACHE_PERIODIC, CACHE_REAL_TIME, NON_CACHED, STORES

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
The number of nodes to request per page. The command follows the pages itself, so this changes how many requests are made, not how many nodes are returned.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.NamingContextNode

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
