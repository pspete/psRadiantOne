---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Invoke-R1PipelineConnectorScript

## SYNOPSIS
Runs the connector scripts of an identity observability pipeline.

## SYNTAX

```
Invoke-R1PipelineConnectorScript [-pipelineId] <String> [-operation] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Runs the configure or deconfigure scripts of a pipeline connector.

## EXAMPLES

### Example 1
```powershell
Invoke-R1PipelineConnectorScript -pipelineId 'somepipeline' -operation CONFIGURE
```

Runs the connector configure scripts.

### Example 2
```powershell
Invoke-R1PipelineConnectorScript -pipelineId 'somepipeline' -operation DECONFIGURE
```

Runs the connector deconfigure scripts.

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

### -operation
The script operation to run. CONFIGURE or DECONFIGURE.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: CONFIGURE, DECONFIGURE

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS
