---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Remove-R1NamespaceView

## SYNOPSIS
Deletes a view.

## SYNTAX

```
Remove-R1NamespaceView [-name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes the named view file from the namespace.

A view which a naming context is mounted on cannot be expected to be removable while that
reference remains.

## EXAMPLES

### Example 1
```powershell
Remove-R1NamespaceView -name 'address book'
```

Deletes the address book view, after prompting for confirmation.

### Example 2
```powershell
Get-R1NamespaceView | Where-Object viewName -eq 'obsolete' | Remove-R1NamespaceView
```

Finds a view by name and deletes it, the view name being taken from the pipeline.

## PARAMETERS

### -name
The name of the view.

```yaml
Type: String
Parameter Sets: (All)
Aliases: viewName

Required: True
Position: 1
Default value: None
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

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1NamespaceView](Get-R1NamespaceView)
