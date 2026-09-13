---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Reset-R1DashboardLink

## SYNOPSIS
Restores the default dashboard links.

## SYNTAX

```
Reset-R1DashboardLink [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Discards the configured dashboard links and restores the defaults, returning the restored list.

## EXAMPLES

### Example 1
```powershell
Reset-R1DashboardLink
```

Restores the default links, after prompting for confirmation.

## PARAMETERS

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.DashboardLink

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DashboardLink](Get-R1DashboardLink)

[Set-R1DashboardLink](Set-R1DashboardLink)
