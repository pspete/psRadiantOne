---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1GlobalInterceptionScript

## SYNOPSIS
Updates the global interception script.

## SYNTAX

```
Set-R1GlobalInterceptionScript [[-scriptContents] <String>] [[-classname] <String>] [[-filename] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the contents of the global interception script.

The current script is retrieved before it is updated, and sent back with the supplied values
applied over it, so a property left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the script as well as
to change it.

## EXAMPLES

### Example 1
```powershell
Set-R1GlobalInterceptionScript -scriptContents (Get-Content .\globalIntercept.java -Raw)
```

Replaces the global interception script with the contents of a local file.

## PARAMETERS

### -scriptContents
The contents of the interception script.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -classname
The name of the class the script declares.

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

### -filename
The name of the file holding the script.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

Test the code with Test-R1InterceptionScriptCode before setting it, and rebuild the jar with
New-R1InterceptionScriptJar afterwards.

## RELATED LINKS

[Get-R1GlobalInterceptionScript](Get-R1GlobalInterceptionScript)

[Test-R1InterceptionScriptCode](Test-R1InterceptionScriptCode)

[New-R1InterceptionScriptJar](New-R1InterceptionScriptJar)
