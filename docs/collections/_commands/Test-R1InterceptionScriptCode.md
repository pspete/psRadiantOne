---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1InterceptionScriptCode

## SYNOPSIS
Compiles interception script code and returns the result.

## SYNTAX

```
Test-R1InterceptionScriptCode [-scriptContents] <String> [[-classname] <String>] [[-filename] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Attempts to compile the supplied interception script code and returns whether it succeeded,
together with the compiler output. Nothing is saved to the server.

## EXAMPLES

### Example 1
```powershell
Get-R1NamingContextInterceptionScriptCode -dn 'o=proxy' | Test-R1InterceptionScriptCode
```

Compiles the interception script of o=proxy as it stands on the server.

### Example 2
```powershell
$Script = Get-R1NamingContextInterceptionScriptCode -dn 'o=proxy'
$Script.scriptContents = $Script.scriptContents -replace 'oldValue', 'newValue'
$Script | Test-R1InterceptionScriptCode
```

Checks that a change to the script compiles, before it is saved with
Set-R1NamingContextInterceptionScriptCode.

### Example 3
```powershell
Get-R1GlobalInterceptionScript | Test-R1InterceptionScriptCode
```

Compiles the global interception script as it currently stands on the server.

## PARAMETERS

### -scriptContents
The contents of the interception script.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.ScriptCompilationResults

## NOTES

The class and file names must be those of an interception script which exists on the server. For
any other names the result reports an invalid script path, whatever the contents sent.

## RELATED LINKS

[Set-R1GlobalInterceptionScript](Set-R1GlobalInterceptionScript)

[New-R1InterceptionScriptJar](New-R1InterceptionScriptJar)
