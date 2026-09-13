---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1Configuration

## SYNOPSIS
Imports a promoted configuration.

## SYNTAX

```
Import-R1Configuration [-apply] <Boolean> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Imports a configuration that was exported from another deployment. With apply false the import is
a dry run: it reports what would happen without changing anything.

## EXAMPLES

### Example 1
```powershell
Import-R1Configuration -apply $false
```

Reports what the import would do, changing nothing.

### Example 2
```powershell
Import-R1Configuration -apply $true
```

Applies the import, after prompting for confirmation.

## PARAMETERS

### -apply
Applies the changes. Set false for a dry run which reports what would happen without changing anything.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: False
Accept pipeline input: True (ByPropertyName)
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

### System.Void

## NOTES

Run a dry run first. The report it produces is read with Get-R1ConfigurationImportReport.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Export-R1Configuration](Export-R1Configuration)

[Get-R1ConfigurationImportReport](Get-R1ConfigurationImportReport)
