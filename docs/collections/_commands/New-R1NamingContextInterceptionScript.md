---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1NamingContextInterceptionScript

## SYNOPSIS
Creates an interception script for a content node.

## SYNTAX

```
New-R1NamingContextInterceptionScript [-dn] <String> [-name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an interception script for the content or container node identified by its DN, and makes it
the script the node uses.

## EXAMPLES

### Example 1
```powershell
New-R1NamingContextInterceptionScript -dn 'EMPLOYEES,o=join' -name 'newScript'
Get-R1NamingContextContentAdvanced -dn 'EMPLOYEES,o=join' | Select-Object interceptionScriptFileName, javaClass
```

Creates a script for the EMPLOYEES node, and shows the file and class the node now uses.

## PARAMETERS

### -dn
The DN of the content or container node.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the script.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

## RELATED LINKS

[Set-R1NamingContextInterceptionScript](Set-R1NamingContextInterceptionScript)

[Get-R1NamingContextContentAdvanced](Get-R1NamingContextContentAdvanced)

[Set-R1NamingContextInterceptionScriptCode](Set-R1NamingContextInterceptionScriptCode)
