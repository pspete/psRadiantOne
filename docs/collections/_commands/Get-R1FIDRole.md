---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1FIDRole

## SYNOPSIS
Returns FID roles.

## SYNTAX

### All (Default)
```
Get-R1FIDRole [<CommonParameters>]
```

### Name
```
Get-R1FIDRole -name <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the FID roles configured on the RadiantOne deployment.

Specify a name to return the full details of a single role, including its permissions. When no name
is specified, every role is returned as a summary of its name and whether it is a default role.

## EXAMPLES

### Example 1
```powershell
Get-R1FIDRole
```

Returns a summary of every role.

### Example 2
```powershell
Get-R1FIDRole -name engineering
```

Returns the full details of the named role.

## PARAMETERS

### -name
The name of the role to return. When omitted, all roles are returned.

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

### psRadiantOne.FIDRole

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
