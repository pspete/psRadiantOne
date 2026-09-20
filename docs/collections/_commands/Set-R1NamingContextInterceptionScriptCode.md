---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextInterceptionScriptCode

## SYNOPSIS
Updates the interception script of a naming context.

## SYNTAX

```
Set-R1NamingContextInterceptionScriptCode [-dn] <String> [-scriptContents] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the source code of the interception script belonging to the naming context node. The
file and class names of the script are retrieved first and sent back unchanged.

## EXAMPLES

### Example 1
```powershell
$Script = Get-R1NamingContextInterceptionScriptCode -dn 'o=proxy'
$Script.scriptContents = $Script.scriptContents -replace 'oldValue', 'newValue'
$Script | Test-R1InterceptionScriptCode
$Script | Set-R1NamingContextInterceptionScriptCode -dn 'o=proxy'
```

Changes the interception script of o=proxy, checking that it compiles before saving it.

## PARAMETERS

### -dn
The DN of the naming context node.

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

### -scriptContents
The complete Java source of the interception script.

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

Test-R1InterceptionScriptCode compiles a script without saving it, and can be used to check a
change before it is saved.

## RELATED LINKS

[Get-R1NamingContextInterceptionScriptCode](Get-R1NamingContextInterceptionScriptCode)

[Test-R1InterceptionScriptCode](Test-R1InterceptionScriptCode)

[Set-R1NamingContextLdapProxyAdvanced](Set-R1NamingContextLdapProxyAdvanced)
