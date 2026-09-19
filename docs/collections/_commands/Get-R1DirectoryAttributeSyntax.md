---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DirectoryAttributeSyntax

## SYNOPSIS
Returns the attribute syntaxes the deployment supports.

## SYNTAX

```
Get-R1DirectoryAttributeSyntax [<CommonParameters>]
```

## DESCRIPTION
Returns the LDAP syntaxes available when defining an attribute, such as the string, integer and
certificate syntaxes.

## EXAMPLES

### Example 1
```powershell
Get-R1DirectoryAttributeSyntax
```

Returns every supported attribute syntax.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Get-R1DirectoryAttribute](Get-R1DirectoryAttribute)

[New-R1DirectoryAttribute](New-R1DirectoryAttribute)
