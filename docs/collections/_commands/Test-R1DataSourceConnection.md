---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1DataSourceConnection

## SYNOPSIS
Tests whether a data source can be connected to.

## SYNTAX

```
Test-R1DataSourceConnection [-DataSource] <Object> [-useExistingCredentials] [<CommonParameters>]
```

## DESCRIPTION
Asks the server to connect using the data source definition supplied, and returns whether it
succeeded. Nothing is saved.

The request body is sent as UTF8 bytes so that a password cannot be captured by Windows
PowerShell parameter binding or module logging.

## EXAMPLES

### Example 1
```powershell
Get-R1DataSource -name 'opendj' | Test-R1DataSourceConnection -useExistingCredentials
```

Tests an existing data source using its stored credentials.

### Example 2
```powershell
$Definition = [pscustomobject]@{ name = 'new'; category = 'ldap'; type = 'Generic LDAP'; host = 'ldap.example.com'; port = 389; bindDn = 'cn=DirectoryManager'; password = 'secret' }
Test-R1DataSourceConnection -DataSource $Definition
```

Tests a definition before creating it.

## PARAMETERS

### -DataSource
The data source to test, as returned by Get-R1DataSource or built by hand.

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

### -useExistingCredentials
Tells the server to keep every stored password, whatever the request body carries.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### psRadiantOne.ConnectionTestResult

## NOTES

Testing an existing data source without -useExistingCredentials sends whatever password the
definition carries, which is an empty string when it came from Get-R1DataSource.

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[New-R1DataSource](New-R1DataSource)
