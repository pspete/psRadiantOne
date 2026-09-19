---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1ObjectInputSource

## SYNOPSIS
Builds the definition of an input source for the object builder.

## SYNTAX

### Namespace
```
New-R1ObjectInputSource -dn <String> -primaryObject <String> -targetBaseDn <String> -objectClass <String>
 -scope <String> [-sizeLimit <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DataSourceSchema
```
New-R1ObjectInputSource -dn <String> -primaryObject <String> -dataSource <String> -schema <String>
 -object <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Builds the definition of an object for the object model of a primary object, complete with its
attributes. The Namespace parameter set describes entries already in the RadiantOne namespace, found
beneath a base DN by object class. The DataSourceSchema parameter set describes a table or object of
a data catalog schema.

Nothing is saved on the server. The definition is returned so that it can be added to the object
model and saved with Set-R1SecondaryObject, as the SAVE button of the object builder does.

## EXAMPLES

### Example 1
```powershell
$Source = New-R1ObjectInputSource -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -targetBaseDn 'ou=Human Resources,o=companydirectory' -objectClass 'inetOrgPerson' -scope 'SUB' -sizeLimit 1
$Model = Get-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES'
$Model.inputSources = @($Model.inputSources) + $Source
$Model | Set-R1SecondaryObject -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES'
```

Adds the inetOrgPerson entries beneath ou=Human Resources,o=companydirectory to the model, ready to be
joined.

### Example 2
```powershell
New-R1ObjectInputSource -dn 'EMPLOYEES,o=join' -primaryObject 'vdAPPEMPLOYEES' -dataSource 'northwind' -schema 'northwind' -object 'APP.SHIPPERS'
```

Returns the definition of the APP.SHIPPERS table of the northwind schema.

## PARAMETERS

### -dn
The DN of the naming context node.

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

### -primaryObject
The name of the primary object, as Get-R1PrimaryObject returns it.

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

### -targetBaseDn
The DN beneath which the entries are found.

```yaml
Type: String
Parameter Sets: Namespace
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -objectClass
The object class of the entries.

```yaml
Type: String
Parameter Sets: Namespace
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -scope
How far beneath the base DN to look: BASE, ONE or SUB.

```yaml
Type: String
Parameter Sets: Namespace
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sizeLimit
The largest number of entries returned for each lookup.

```yaml
Type: Int32
Parameter Sets: Namespace
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dataSource
The name of the data source.

```yaml
Type: String
Parameter Sets: DataSourceSchema
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -schema
The name of the data catalog schema describing the data source.

```yaml
Type: String
Parameter Sets: DataSourceSchema
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -object
The table or object of the schema, for example APP.SHIPPERS.

```yaml
Type: String
Parameter Sets: DataSourceSchema
Aliases:

Required: True
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

### psRadiantOne.InputSource

## NOTES

A data source schema object which no join uses is dropped by the server when the model is saved.

## RELATED LINKS

[New-R1JoinProfile](New-R1JoinProfile)

[New-R1ObjectExtension](New-R1ObjectExtension)

[Set-R1SecondaryObject](Set-R1SecondaryObject)

[Get-R1SecondaryObject](Get-R1SecondaryObject)
