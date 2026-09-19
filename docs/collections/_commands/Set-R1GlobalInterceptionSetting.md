---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1GlobalInterceptionSetting

## SYNOPSIS
Updates the global interception settings.

## SYNTAX

```
Set-R1GlobalInterceptionSetting [-preOperationInterceptOn <String[]>]
 [-postOperationInterceptAfter <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the operations which invoke the global interception script, before and after they are
carried out.

The current settings are retrieved and sent back with the supplied values applied over them, so a
value which is not specified keeps its current setting. A collection which is specified replaces
the collection currently configured, rather than adding to it.

The Java class implementing the global interception script is set by the server and cannot be
changed here.

## EXAMPLES

### Example 1
```powershell
Set-R1GlobalInterceptionSetting -preOperationInterceptOn 'BIND', 'SEARCH'
```

Invokes the global interception script before bind and search operations. The operations
intercepted after the event are left as they are.

### Example 2
```powershell
Set-R1GlobalInterceptionSetting -postOperationInterceptAfter @()
```

Stops the global interception script being invoked after any operation.

## PARAMETERS

### -preOperationInterceptOn
The operations which invoke the global interception script before they are carried out.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: BIND, MODIFY, DELETE, ADD, COMPARE, SEARCH, SPECIAL_OPERATION

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -postOperationInterceptAfter
The operations which invoke the global interception script after they are carried out.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: BIND, MODIFY, DELETE, ADD, SEARCH_RESULT_ENTRY_PROCESSING

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Get-R1GlobalInterceptionSetting](Get-R1GlobalInterceptionSetting)
