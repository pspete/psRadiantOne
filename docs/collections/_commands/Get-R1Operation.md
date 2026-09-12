---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1Operation

## SYNOPSIS
Returns entry statistics refresh operations.

## SYNTAX

### All (Default)
```
Get-R1Operation [<CommonParameters>]
```

### Name
```
Get-R1Operation -name <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the entry statistics refresh operations and their status. A refresh which runs long enough
to be tracked as an operation carries its entry statistics in the result once it completes.

Specify a name to return a single operation.

## EXAMPLES

### Example 1
```powershell
Get-R1Operation
```

Returns every refresh operation.

### Example 2
```powershell
Get-R1Operation -name $operationName
```

Returns a single refresh operation and its status.

## PARAMETERS

### -name
The identifier of the refresh operation, which the API issues as a UUID when the operation starts.

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

### psRadiantOne.RefreshOperation

## NOTES

## RELATED LINKS
