---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1LdapDataPreview

## SYNOPSIS
Previews the data an LDAP data source holds.

## SYNTAX

```
Get-R1LdapDataPreview [-dataSourceName] <String> [[-baseDn] <String>] [<CommonParameters>]
```

## DESCRIPTION
Reads directly from an existing LDAP data source and returns what is there, without creating a
schema. Without a base DN the root is returned; with one, its children are.

## EXAMPLES

### Example 1
```powershell
Get-R1LdapDataPreview -dataSourceName 'companydirectory'
```

Returns the root of the companydirectory data source.

### Example 2
```powershell
Get-R1LdapDataPreview -dataSourceName 'companydirectory' -baseDn 'o=companydirectory'
```

Returns the entries beneath a base DN.

### Example 3
```powershell
Get-R1DataSource -name 'companydirectory' | Get-R1LdapDataPreview
```

Takes the data source name from the pipeline.

## PARAMETERS

### -dataSourceName
The name of the LDAP data source to read from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -baseDn
The DN to read beneath. Without it, the root is returned.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.PreviewBaseDnResponse

## NOTES

Only an LDAP data source can be previewed. Naming a database one is refused with
"Invalid data source, must be an LDAP data source".

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[New-R1Schema](New-R1Schema)
