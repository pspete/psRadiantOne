---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1Feature

## SYNOPSIS
Sets the value of a feature flag.

## SYNTAX

```
Set-R1Feature [-flagId] <String> [-value] <Boolean> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the value of one or more feature flags.

The API replaces the whole collection of flags on update, so this command retrieves every flag
first and applies the requested changes over them. Flags which were not named keep their current
value rather than being dropped. Naming a flag the deployment does not have is an error, rather
than silently adding one.

Several flags can be set in one request by piping them in, since the collection is sent once when
the pipeline completes.

## EXAMPLES

### Example 1
```powershell
Set-R1Feature -flagId someFeature -value $true
```

Enables one feature flag.

### Example 2
```powershell
@( @{ flagId = 'featureA'; value = $true }, @{ flagId = 'featureB'; value = $false } ) | Set-R1Feature
```

Sets two flags in a single request.

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

### -flagId
The identifier of the feature flag.

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

### -value
Whether the feature is enabled.

```yaml
Type: Boolean
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

### System.String

### System.Boolean

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
