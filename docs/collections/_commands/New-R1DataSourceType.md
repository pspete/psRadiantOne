---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1DataSourceType

## SYNOPSIS
Creates a data source type.

## SYNTAX

### Ldap (Default)
```
New-R1DataSourceType -name <String> [-description <String>] [-icon <String>] -isLdap <Boolean> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Database
```
New-R1DataSourceType -name <String> [-description <String>] [-icon <String>] -driverClass <String>
 -urlPattern <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Custom
```
New-R1DataSourceType -name <String> [-description <String>] [-icon <String>] -javaClassName <String>
 [-pluginName <String>] [-meta <Object[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a data source type. Which kind is created is decided by the parameters supplied: an LDAP
type needs isLdap, a database type needs a driver class and URL pattern, and a custom type needs
a Java class name.

## EXAMPLES

### Example 1
```powershell
New-R1DataSourceType -name 'My LDAP' -isLdap $true
```

Creates an LDAP data source type.

### Example 2
```powershell
New-R1DataSourceType -name 'My DB' -driverClass 'org.postgresql.Driver' -urlPattern 'jdbc:postgresql://{host}:{port}/{database}'
```

Creates a database data source type.

### Example 3
```powershell
New-R1DataSourceType -name 'My Custom' -javaClassName 'com.example.Connector' -pluginName 'example'
```

Creates a custom data source type provided by a plugin.

## PARAMETERS

### -name
The name of the data source type.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isLdap
--------------------------------------------------------------------------------- ldap

```yaml
Type: Boolean
Parameter Sets: Ldap
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -driverClass
----------------------------------------------------------------------------- database

```yaml
Type: String
Parameter Sets: Database
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -urlPattern
The pattern used to build the JDBC URL.

```yaml
Type: String
Parameter Sets: Database
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -javaClassName
------------------------------------------------------------------------------- custom

```yaml
Type: String
Parameter Sets: Custom
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pluginName
The name of the plugin.

```yaml
Type: String
Parameter Sets: Custom
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -meta
The property descriptors of the type, each describing one setting a data source of this type carries.

```yaml
Type: Object[]
Parameter Sets: Custom
Aliases:

Required: False
Position: Named
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

### psRadiantOne.DataSourceType

## NOTES

## RELATED LINKS

[Get-R1DataSourceType](Get-R1DataSourceType)

[Set-R1DataSourceType](Set-R1DataSourceType)
