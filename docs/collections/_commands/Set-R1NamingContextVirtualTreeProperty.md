---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextVirtualTreeProperty

## SYNOPSIS
Updates the virtual tree properties of a naming context.

## SYNTAX

```
Set-R1NamingContextVirtualTreeProperty [-dn] <String> [[-directoryView] <String>] [[-isActive] <Boolean>]
 [[-dataSourceType] <String>] [[-dataSourceName] <String>] [[-virtualAttributes] <Object[]>]
 [[-baseDn] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the properties of the virtual tree mounted at the naming context node.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1NamingContextVirtualTreeProperty -dn 'ou=hr,o=aggregate' -isActive $false
```

Deactivates the virtual tree at ou=hr,o=aggregate, leaving its other properties as they are.

### Example 2
```powershell
Set-R1NamingContextVirtualTreeProperty -dn 'ou=hr,o=aggregate' -isActive $true
```

Activates it again.

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

### -directoryView
The name of the directory view the virtual tree presents.

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

### -isActive
Whether the virtual tree is active.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dataSourceType
The category of the backing data source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dataSourceName
The name of the backing data source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -virtualAttributes
The virtual attributes, each mapping a name to the name it is presented as.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -baseDn
The base DN of the backing data.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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

The naming context and schema are maintained by the server and cannot be changed here. They are
sent back unaltered so that the update carries the complete resource.

A collection which is specified replaces the collection currently configured, rather than being
added to it. Retrieve the current value, add to it and pass the result back to append.

## RELATED LINKS

[Get-R1NamingContextVirtualTreeProperty](Get-R1NamingContextVirtualTreeProperty)
