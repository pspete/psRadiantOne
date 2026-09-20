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

No command lists pipelines, and a pipeline id cannot be built from what this module reads: the
identity source half of it lives under the global profiles branch, which the API does not expose.
Take the id from the control panel.

The configuration comes back empty rather than as an error for an id that resolves to nothing, so
an empty result proves neither that the id was right nor that it was wrong.

## RELATED LINKS
