---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1NamingContextContentProperty

## SYNOPSIS
Updates the properties of a content or container naming context node.

## SYNTAX

```
Set-R1NamingContextContentProperty [-dn] <String> [[-rdnName] <String>] [[-rdnValues] <String[]>]
 [[-primaryKey] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates how the entries of the content or container node identified by its DN are named: the RDN
attribute, the columns its value is built from, and the primary key.

The current settings are retrieved before they are updated, and sent back with the supplied values
applied over them, so a setting left unspecified keeps its current value. The command therefore
issues a GET followed by a PUT, and the account needs permission to read the settings as well as
to change them.

## EXAMPLES

### Example 1
```powershell
Set-R1NamingContextContentProperty -dn 'EMPLOYEES,ou=hr,o=views' -rdnName 'uid'
```

Names the entries of the EMPLOYEES node by uid. The node itself is renamed to uid,ou=hr,o=views.

### Example 2
```powershell
Set-R1NamingContextContentProperty -dn 'uid,ou=hr,o=views' -rdnValues 'APP.EMPLOYEES.FIRSTNAME', 'APP.EMPLOYEES.LASTNAME'
```

Builds the RDN value of each entry from the first and last name columns.

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

### -rdnName
The attribute naming each entry.

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

### -rdnValues
The columns the RDN value is built from, named as Get-R1NamingContextContentRdnAttribute returns
them.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -primaryKey
The column identifying each entry.

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

The node is named by its RDN attribute, so changing rdnName renames the node: its DN afterwards
begins with the new name, and the old DN is no longer found.

The schema and node type are maintained by the server and cannot be changed here. They are sent
back unaltered so that the update carries the complete resource.

## RELATED LINKS

[Get-R1NamingContextContentProperty](Get-R1NamingContextContentProperty)

[Get-R1NamingContextContentRdnAttribute](Get-R1NamingContextContentRdnAttribute)

[Set-R1NamingContextContentAdvanced](Set-R1NamingContextContentAdvanced)
