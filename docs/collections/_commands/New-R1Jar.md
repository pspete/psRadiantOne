---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1Jar

## SYNOPSIS
Builds a jar on the server.

## SYNTAX

```
New-R1Jar [-type] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Builds one of the jars the deployment compiles from its own source, and returns the exit code and
output of the build.

## EXAMPLES

### Example 1
```powershell
New-R1Jar -type 'ALL'
```

Builds every jar.

### Example 2
```powershell
New-R1Jar -type 'INTERCEPT'
```

Builds the interception script jar.

## PARAMETERS

### -type
Which jar to build.

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

### psRadiantOne.JarBuildResult

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[New-R1InterceptionScriptJar](New-R1InterceptionScriptJar)

[Get-R1FileManagerDirectory](Get-R1FileManagerDirectory)
