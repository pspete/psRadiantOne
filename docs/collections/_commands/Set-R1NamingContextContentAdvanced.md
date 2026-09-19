---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextContentAdvanced

## SYNOPSIS
Updates the advanced settings of a content or container naming context node.

## SYNTAX

```
Set-R1NamingContextContentAdvanced [-dn] <String> [[-interceptOn] <String[]>] [[-objectClassMapping] <String>]
 [[-processJoinComputedAttrsNecessary] <Boolean>] [[-requestNecessaryAttrOnly] <Boolean>]
 [[-distinct] <Boolean>] [[-leftOuterJoin] <Boolean>] [[-searchCaseSensitivity] <String>]
 [[-sqlWhereClause] <String>] [[-ldapFilter] <String>] [[-maxRequestedAttributes] <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Updates the advanced settings of the content or container node identified by its DN: the object
class mapping, the SQL where clause and LDAP filter applied to its data, the operations its
interception script handles, and how queries are built.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1NamingContextContentAdvanced -dn 'uid,ou=hr,o=views' -objectClassMapping 'top # person # organizationalPerson # inetorgperson'
```

Presents the entries of the node with the inetOrgPerson object class and its superclasses.

### Example 2
```powershell
Set-R1NamingContextContentAdvanced -dn 'uid,ou=hr,o=views' -sqlWhereClause "COUNTRY = 'UK'"
```

Restricts the entries of the node to the rows the where clause selects.

## PARAMETERS

### -dn
The DN of the content or container node.

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

### -interceptOn
The operations the interception script handles.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -objectClassMapping
The object classes the entries are presented with, separated by ' # '.

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

### -processJoinComputedAttrsNecessary
Whether joins and computed attributes are only processed when a request needs them.

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

### -requestNecessaryAttrOnly
Whether only the columns a request needs are retrieved.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -distinct
Whether queries return distinct rows only.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -leftOuterJoin
Whether related objects are joined with a left outer join.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -searchCaseSensitivity
How the case of search values is treated: AS_IS, IGNORE_CASE or TRANSLATE_TO_UPPER.

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

### -sqlWhereClause
A where clause applied to every query.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ldapFilter
An LDAP filter applied to every entry.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -maxRequestedAttributes
The largest number of attributes requested from the data source at once.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
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

A where clause cannot be cleared with this command: an empty -sqlWhereClause is sent as null, and
the server keeps the clause it has. An empty -ldapFilter is sent the same way.

The interception script location, Java class, object class, data source type and LDAP filter
attributes are maintained by the server and cannot be changed here. They are sent back unaltered so
that the update carries the complete resource.

This command has not been exercised against a live deployment.

## RELATED LINKS

[Get-R1NamingContextContentAdvanced](Get-R1NamingContextContentAdvanced)

[Set-R1NamingContextContentProperty](Set-R1NamingContextContentProperty)
