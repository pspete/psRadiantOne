---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Mount-R1NamingContextBackend

## SYNOPSIS
Mounts a backend on a naming context node.

## SYNTAX

### LdapProxy
```
Mount-R1NamingContextBackend -dn <String> -datasource <String> -remoteBaseDn <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### DbProxy
```
Mount-R1NamingContextBackend -dn <String> -datasource <String> -tableViews <String[]> [-schema <String>]
 [-isQuoteTableNames <Boolean>] [-isQuoteColumnNames <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Mounts a backend at the naming context node identified by its DN, so that the node presents the
data held in an LDAP directory or a database.

The LdapProxy parameter set proxies an LDAP data source from a remote base DN. The DbProxy
parameter set presents tables or views of a database data source, each as a content node beneath
the mounted node.

## EXAMPLES

### Example 1
```powershell
Mount-R1NamingContextBackend -dn 'o=proxy' -datasource 'vds' -remoteBaseDn 'o=companydirectory'
```

Presents o=companydirectory of the vds data source at o=proxy.

### Example 2
```powershell
Mount-R1NamingContextBackend -dn 'ou=hr,o=aggregate' -datasource 'northwind' -schema 'northwind' -tableViews 'APP.EMPLOYEES'
```

Presents the APP.EMPLOYEES table of the northwind database beneath ou=hr,o=aggregate.

## PARAMETERS

### -dn
The DN of the naming context node to mount the backend on.

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

### -datasource
The name of the data source to mount.

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

### -remoteBaseDn
The DN in the LDAP data source whose entries are presented.

```yaml
Type: String
Parameter Sets: LdapProxy
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tableViews
The tables or views to present, named as they appear in the data catalog schema, for example
APP.EMPLOYEES.

```yaml
Type: String[]
Parameter Sets: DbProxy
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -schema
The data catalog schema describing the database.

```yaml
Type: String
Parameter Sets: DbProxy
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isQuoteTableNames
Whether table names are quoted in the queries sent to the database.

```yaml
Type: Boolean
Parameter Sets: DbProxy
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isQuoteColumnNames
Whether column names are quoted in the queries sent to the database.

```yaml
Type: Boolean
Parameter Sets: DbProxy
Aliases:

Required: False
Position: Named
Default value: False
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

The node must be a root naming context or a label which has no backend of its own.

The API also defines RadiantOne Directory, virtual tree and DSML/SPML service backends, which this
command does not mount.

## RELATED LINKS

[New-R1NamingContext](New-R1NamingContext)

[New-R1NamingContextLabel](New-R1NamingContextLabel)

[Get-R1NamingContext](Get-R1NamingContext)
