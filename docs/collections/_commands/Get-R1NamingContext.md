---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContext

## SYNOPSIS
Returns naming contexts.

## SYNTAX

### All (Default)
```
Get-R1NamingContext [-activeOnly <Boolean>] [-datasources <String[]>] [-searchFilter <String>]
 [-typeFilter <String>] [-limit <Int32>] [<CommonParameters>]
```

### Dn
```
Get-R1NamingContext -dn <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the root naming contexts of the directory namespace, or a single node identified by its DN.

The list form follows the pagination of the API and returns every page, so the whole collection is
returned rather than only its first page.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContext
```

Returns every root naming context.

### Example 2
```powershell
Get-R1NamingContext -dn 'o=vds'
```

Returns the naming context node at o=vds.

### Example 3
```powershell
Get-R1NamingContext -activeOnly $true -typeFilter 'STORES'
```

Returns the active root naming contexts which are stores.

### Example 4
```powershell
Get-R1NamingContext | Where-Object hasChildren | Get-R1NamingContextChild
```

Returns the child nodes of every root naming context which has any.

## PARAMETERS

### -dn
The DN of the naming context node.

```yaml
Type: String
Parameter Sets: Dn
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -activeOnly
Returns only naming contexts which are active.

```yaml
Type: Boolean
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -datasources
Returns only naming contexts using the named data sources.

```yaml
Type: String[]
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -searchFilter
Returns only naming contexts whose name or data source matches the given string.

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -typeFilter
Returns only nodes of the given type.

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
The number of nodes to request per page. The command follows the pages itself, so this changes how many requests are made, not how many nodes are returned.

```yaml
Type: Int32
Parameter Sets: All
Aliases:

Required: False
Position: Named
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

[Get-R1NamingContextChild](Get-R1NamingContextChild)

[New-R1NamingContext](New-R1NamingContext)

[Remove-R1NamingContext](Remove-R1NamingContext)
