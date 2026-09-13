---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1DataSourceType

## SYNOPSIS
Updates a data source type.

## SYNTAX

```
Set-R1DataSourceType [-name] <String> [[-description] <String>] [[-icon] <String>] [[-isLdap] <Boolean>]
 [[-driverClass] <String>] [[-urlPattern] <String>] [[-javaClassName] <String>] [[-pluginName] <String>]
 [[-meta] <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a data source type.

The current type is retrieved and sent back with the supplied values applied over it, so a
property left unspecified keeps its current value. Because the properties differ by backend
category, the request is built from what the API returned rather than from a fixed list.

## EXAMPLES

### Example 1
```powershell
Set-R1DataSourceType -name 'My Custom' -description 'Connector for the example system'
```

Changes the description, leaving every other property as it is.

## PARAMETERS

### -name
The name of the data source type.

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

### -description
A description of the data source type.

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

### -icon
The icon shown for the type in the control panel.

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

### -isLdap
Whether the type describes an LDAP backend.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -driverClass
The JDBC driver class the type connects with.

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

### -urlPattern
The pattern used to build the JDBC URL.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -javaClassName
The Java class implementing the custom type.

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

### -pluginName
The name of the plugin.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -meta
The property descriptors of the type, each describing one setting a data source of this type carries.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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

Data source types do not all carry the same properties. An LDAP type has isLdap, a database
type has driverClass and urlPattern, and a custom type has javaClassName, pluginName and a
writable meta collection. Which properties a type has is decided by its backend category.

The meta collection is read only for LDAP and database types, and writable only for
custom ones.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSourceType](Get-R1DataSourceType)

[New-R1DataSourceType](New-R1DataSourceType)
