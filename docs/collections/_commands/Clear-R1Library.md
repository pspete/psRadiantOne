---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Clear-R1Library

## SYNOPSIS
Removes libraries nothing depends on.

## SYNTAX

```
Clear-R1Library [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes every library which nothing refers to, and returns what was removed.

## EXAMPLES

### Example 1
```powershell
Clear-R1Library
```

Removes unreferenced libraries, after prompting for confirmation.

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

### psRadiantOne.LibraryCleanResult

## NOTES

Nothing of this kind was configured on the deployment used while building the module, so the
behaviour of this command rests on the published API definition alone.

## RELATED LINKS

[Get-R1Library](Get-R1Library)

[Get-R1LibraryDependent](Get-R1LibraryDependent)
