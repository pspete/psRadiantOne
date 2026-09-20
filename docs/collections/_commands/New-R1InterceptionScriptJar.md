---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1InterceptionScriptJar

## SYNOPSIS
Rebuilds the interception script jar.

## SYNTAX

```
New-R1InterceptionScriptJar [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Rebuilds the jar holding the compiled interception scripts, and returns the exit code and build
output of the build that ran.

## EXAMPLES

### Example 1
```powershell
New-R1InterceptionScriptJar
```

Rebuilds the interception script jar and returns the build results.

### Example 2
```powershell
(New-R1InterceptionScriptJar).exitCode
```

Rebuilds the jar and returns just the exit code, which is zero when the build succeeded.

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

### psRadiantOne.InterceptionJarBuildResults

## NOTES

## RELATED LINKS

[Set-R1GlobalInterceptionScript](Set-R1GlobalInterceptionScript)

[Test-R1InterceptionScriptCode](Test-R1InterceptionScriptCode)
