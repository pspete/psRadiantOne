---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextInterceptionScript

## SYNOPSIS
Sets a content node to use an existing interception script.

## SYNTAX

```
Set-R1NamingContextInterceptionScript [-dn] <String> [-scriptPath] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Sets the content or container node identified by its DN to use an interception script which already
exists, such as the script of another node.

## EXAMPLES

### Example 1
```powershell
Set-R1NamingContextInterceptionScript -dn 'EMPLOYEES,o=join' -scriptPath 'employees_o_joindir.java'
```

Sets the EMPLOYEES node to use the script of the EMPLOYEES node of o=joindir.

### Example 2
```powershell
$Script = (Get-R1NamingContextContentAdvanced -dn 'EMPLOYEES,o=joindir').interceptionScriptFileName
Set-R1NamingContextInterceptionScript -dn 'EMPLOYEES,o=join' -scriptPath $Script
```

Does the same, taking the file name from the other node.

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

### -scriptPath
The file name of the script, as the interceptionScriptFileName of the node using it gives it.

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

[New-R1NamingContextInterceptionScript](New-R1NamingContextInterceptionScript)

[Get-R1NamingContextContentAdvanced](Get-R1NamingContextContentAdvanced)
