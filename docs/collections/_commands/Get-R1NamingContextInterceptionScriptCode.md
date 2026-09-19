---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1NamingContextInterceptionScriptCode

## SYNOPSIS
Returns the interception script of a naming context node.

## SYNTAX

```
Get-R1NamingContextInterceptionScriptCode [-dn] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the class name, file name and source of the interception script of a content node or LDAP proxy.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextInterceptionScriptCode -dn 'o=companyprofiles'
```

Returns the interception script of a naming context node at o=companyprofiles.

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

### psRadiantOne.InterceptionScriptContents

## NOTES

## RELATED LINKS

[Get-R1NamingContext](Get-R1NamingContext)
