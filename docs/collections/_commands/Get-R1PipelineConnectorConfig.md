---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1PipelineConnectorConfig

## SYNOPSIS
Returns the connector configuration of an identity observability pipeline.

## SYNTAX

```
Get-R1PipelineConnectorConfig [-pipelineId] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the connector configuration of a pipeline, comprising the connector type and its
properties.

## EXAMPLES

### Example 1
```powershell
Get-R1PipelineConnectorConfig -pipelineId 'somepipeline'
```

Returns the connector configuration.

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

### psRadiantOne.ConnectorConfig

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
