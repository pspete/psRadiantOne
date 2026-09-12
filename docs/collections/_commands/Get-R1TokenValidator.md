---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1TokenValidator

## SYNOPSIS
Returns external token validators.

## SYNTAX

### All (Default)
```
Get-R1TokenValidator [<CommonParameters>]
```

### Name
```
Get-R1TokenValidator -name <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the external token validators configured on the deployment. Specify a name to return a
single validator; when no name is given, every validator is returned.

This command has not been exercised against a live deployment. No external token validator was configured on the deployment available, and one could not be created there, so its behaviour rests on the published API schema alone.

## EXAMPLES

### Example 1
```powershell
Get-R1TokenValidator
```

Returns every external token validator.

### Example 2
```powershell
Get-R1TokenValidator -name 'partner-idp'
```

Returns the named validator.

## PARAMETERS

### -name
The name of the external token validator.

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.ExternalTokenValidator

## NOTES

## RELATED LINKS
