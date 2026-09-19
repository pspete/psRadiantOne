---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1PipelineConnectorType

## SYNOPSIS
Returns the connector types available to a pipeline.

## SYNTAX

```
Get-R1PipelineConnectorType [-pipelineId] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the connector types a pipeline may be configured with, which are the values accepted by
the type of Set-R1PipelineConnectorConfig.

## EXAMPLES

### Example 1
```powershell
Get-R1PipelineConnectorType -pipelineId 'somepipeline'
```

Returns the available connector types.

## PARAMETERS

### -pipelineId
The identifier of the identity observability pipeline.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
