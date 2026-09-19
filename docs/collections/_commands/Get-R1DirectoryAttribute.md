---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1DirectoryAttribute

## SYNOPSIS
Returns the attributes in the directory schema.

## SYNTAX

### All (Default)
```
Get-R1DirectoryAttribute [-includeAllProperties <Boolean>] [-includeSuperior <Boolean>]
 [-isUserDefined <Boolean>] [-attributeObjectClasses <String[]>] [<CommonParameters>]
```

### Attribute
```
Get-R1DirectoryAttribute -attribute <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the attributes of the LDAP schema, or the full definition of a single attribute when one
is named.

The list form returns attribute names by default and full definitions when includeAllProperties
is specified. Which form the server sent is reported by the response itself, so the command
returns whichever it receives.

## EXAMPLES

### Example 1
```powershell
Get-R1DirectoryAttribute
```

Returns the name of every attribute in the schema.

### Example 2
```powershell
Get-R1DirectoryAttribute -includeAllProperties $true
```

Returns the full definition of every attribute.

### Example 3
```powershell
Get-R1DirectoryAttribute -attribute 'cn'
```

Returns the full definition of the cn attribute.

### Example 4
```powershell
Get-R1DirectoryAttribute -attributeObjectClasses 'inetOrgPerson' -includeSuperior $true
```

Returns the attributes of inetOrgPerson, including those it inherits.

## PARAMETERS

### -attribute
The name of the attribute.

```yaml
Type: String
Parameter Sets: Attribute
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -includeAllProperties
Returns the full definition of each attribute rather than only its name.

```yaml
Type: Boolean
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeSuperior
Resolves superior object classes and includes their attributes in the result.

```yaml
Type: Boolean
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -isUserDefined
Sorts the attributes by whether they are user defined.

```yaml
Type: Boolean
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -attributeObjectClasses
Returns only the attributes belonging to the named object classes.

```yaml
Type: String[]
Parameter Sets: All
Aliases:

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

### psRadiantOne.DirectorySchemaAttribute

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[New-R1DirectoryAttribute](New-R1DirectoryAttribute)

[Set-R1DirectoryAttribute](Set-R1DirectoryAttribute)

[Remove-R1DirectoryAttribute](Remove-R1DirectoryAttribute)

[Get-R1DirectoryAttributeSyntax](Get-R1DirectoryAttributeSyntax)
