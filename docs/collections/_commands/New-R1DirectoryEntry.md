---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# New-R1DirectoryEntry

## SYNOPSIS
Adds an entry to the directory.

## SYNTAX

### Attributes (Default)
```
New-R1DirectoryEntry [-dn] <String> [-attributes] <Object[]> [[-rdn] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ObjectClass
```
New-R1DirectoryEntry [-dn] <String> [[-rdn] <String>] -objectClass <String[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Adds an entry at the given DN with the attributes supplied.

Given object classes in place of attributes, the command reads them from the directory schema,
following each up through its superclasses, and offers a parameter for every attribute an entry of
those classes can carry, named after the attribute and taking any alias the schema gives it. A
multivalued attribute takes a list, and an attribute the schema requires is mandatory. The entry is
sent with every object class reached, and with the attributes given as parameters.

These parameters are only offered when -objectClass is given as a literal value, rather than from
the pipeline, and a session is connected, as they are read from the schema while the command's
parameters are bound. They are not listed in this help.

The request body is sent as UTF8 bytes, so an attribute value carrying a credential cannot be
captured by Windows PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
New-R1DirectoryEntry -dn 'ou=people,o=example' -attributes @{
    objectClass = 'top', 'organizationalUnit'
    ou          = 'people'
}
```

Adds an organizational unit. Each key is an attribute name; an attribute with several values takes
a list.

### Example 2
```powershell
New-R1DirectoryEntry -dn 'uid=one,ou=people,o=example' -attributes @{
    objectClass = 'top', 'person', 'organizationalPerson', 'inetOrgPerson'
    uid         = 'one'
    cn          = 'User One'
    sn          = 'One'
}
```

Adds a user. The DN is the full DN of the new entry, not the DN of its parent.

### Example 3
```powershell
$Attributes = @(
    [pscustomobject]@{ name = 'objectClass'; values = @('top', 'organizationalUnit') }
    [pscustomobject]@{ name = 'ou'; values = @('people') }
)
New-R1DirectoryEntry -dn 'ou=people,o=example' -attributes $Attributes
```

Adds an organizational unit, with the attributes given in the shape the API takes them.

### Example 4
```powershell
New-R1DirectoryEntry -dn 'uid=one,ou=people,o=example' -objectClass inetOrgPerson -cn 'User One' -sn One -uid one -mail one@example.com
```

Adds a user, with the object classes top, person, organizationalPerson and inetOrgPerson, from
parameters built from the schema.

## PARAMETERS

### -dn
The DN of the entry.

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

### -attributes
The attributes of the new entry, as a hashtable keyed by attribute name, with an attribute's
values as its value.

Attributes already in the shape the API takes them, each with name and values properties, are sent
unchanged.

```yaml
Type: Object[]
Parameter Sets: Attributes
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -rdn
The RDN of the entry. The API names the new entry by its dn, so this is not a way to create a
child of the dn given.

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

### -objectClass
The object classes of the entry, structural and auxiliary. Their superclasses are added to the
entry, and their attributes are offered as parameters.

```yaml
Type: String[]
Parameter Sets: ObjectClass
Aliases:

Required: True
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

The dn is the dn of the entry to create. Supplying the dn of the parent entry with an rdn does
not create a child: the API attempts to create the dn given, and fails because it already
exists.

## RELATED LINKS

[Get-R1DirectoryEntry](Get-R1DirectoryEntry)

[Set-R1DirectoryEntry](Set-R1DirectoryEntry)
