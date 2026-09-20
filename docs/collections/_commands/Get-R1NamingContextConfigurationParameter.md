---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextConfigurationParameter

## SYNOPSIS
Returns the configuration parameters of a content node.

## SYNTAX

```
Get-R1NamingContextConfigurationParameter [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the configuration parameters of a content or container node: its link parameters, the additional clause and the base search and update parameters of its queries, and the stored procedures it calls on insert, update and delete.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextConfigurationParameter -dn 'EMPLOYEES,o=DBJoin'
```

Returns the configuration parameters of a content node at EMPLOYEES,o=DBJoin.

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

### psRadiantOne.ConfigurationParameters

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
