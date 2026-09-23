---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1PipelineConnectorConfig

## SYNOPSIS
Updates the connector configuration of an identity observability pipeline.

## SYNTAX

```
Set-R1PipelineConnectorConfig [-pipelineId] <String> [-properties] <Object[]> [[-type] <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the connector configuration of a pipeline.

The current configuration is retrieved before it is updated, so the connector type is preserved
when only the properties are being changed. The command issues a GET followed by a PUT.

## EXAMPLES

### Example 1
```powershell
Set-R1PipelineConnectorConfig -pipelineId 'somepipeline' -properties @{ host = 'splunk.example.com' }
```

Sets a connector property, keeping the connector type.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -properties
The connector properties, as a hashtable keyed by property name.

Properties already in the shape the API takes them, each with name and value properties, are sent
unchanged.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
The connector type. Get-R1PipelineConnectorType returns those available for a pipeline.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Object[]

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
