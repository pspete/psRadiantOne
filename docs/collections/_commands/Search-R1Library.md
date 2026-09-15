---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Search-R1Library

## SYNOPSIS
Searches the libraries in the catalog.

## SYNTAX

```
Search-R1Library [[-filter] <String>] [<CommonParameters>]
```

## DESCRIPTION
Searches for libraries matching a filter.

## EXAMPLES

### Example 1
```powershell
Search-R1Library -filter 'postgres'
```

Returns libraries matching postgres.

## PARAMETERS

### -filter
Returns only libraries matching this string.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

### psRadiantOne.Library

## NOTES

## RELATED LINKS

[Get-R1Library](Get-R1Library)
