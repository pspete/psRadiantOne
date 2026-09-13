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
Get-R1LdapDataPreview [-DataSource] <Object> [[-baseDn] <String>] [<CommonParameters>]
```

## DESCRIPTION
Reads directly from an LDAP data source and returns what is there, without creating a schema.
The data source is given either as the name of an existing one or as the connection details for
a new one. Without a base DN the root is returned; with one, its children are.

The request body is sent as UTF8 bytes so that a password in the connection details cannot be
captured by Windows PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
Get-R1LdapDataPreview -DataSource ([pscustomobject]@{ existingDataSource = $true; dataSourceName = 'opendj' })
```

Returns the root of an existing data source.

### Example 2
```powershell
Get-R1LdapDataPreview -DataSource $Definition -baseDn 'o=example'
```

Returns the entries beneath a base DN.

## PARAMETERS

### -DataSource
The LDAP data source to read from: either an existing one named, or the connection details for a new one.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

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

Nothing of this kind was configured on the deployment used while building the module, so the
behaviour of this command rests on the published API definition alone.

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[New-R1Schema](New-R1Schema)
