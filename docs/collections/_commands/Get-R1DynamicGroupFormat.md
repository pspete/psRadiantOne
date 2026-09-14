---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DynamicGroupFormat

## SYNOPSIS
Returns the dynamic group DN format for a DN.

## SYNTAX

```
Get-R1DynamicGroupFormat [-dynamicGroupDn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the form the given dynamic group DN takes, which is either an LDAP URL or a plain DN.

## EXAMPLES

### Example 1
```powershell
Get-R1DynamicGroupFormat -dynamicGroupDn 'cn=dyngroup,o=companydirectory'
```

Returns the dynamic group format for that DN.

## PARAMETERS

### -dynamicGroupDn
The DN of the dynamic group.

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

### psRadiantOne.DynamicGroupFormat

## NOTES

## RELATED LINKS

[Get-R1GlobalDynamicGroup](Get-R1GlobalDynamicGroup)
