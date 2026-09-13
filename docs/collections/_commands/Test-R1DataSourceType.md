---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Test-R1DataSourceType

## SYNOPSIS
Reports whether a driver class is loaded.

## SYNTAX

```
Test-R1DataSourceType [-className] <String> [<CommonParameters>]
```

## DESCRIPTION
Asks the server whether the named Java class is loaded and available, which is how a JDBC driver
is checked before a database data source is created against it.

## EXAMPLES

### Example 1
```powershell
Test-R1DataSourceType -className 'org.postgresql.Driver'
```

Returns true when the driver is loaded.

### Example 2
```powershell
Get-R1DataSourceType -name 'Generic DB' | Test-R1DataSourceType
```

Checks the driver class of a data source type, which is pipeline bound through its driverClass property.

## PARAMETERS

### -className
The fully qualified name of the Java class to look for.

```yaml
Type: String
Parameter Sets: (All)
Aliases: driverClass

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Boolean

## NOTES

This command has not been exercised against a live deployment, so its behaviour rests on the
published API definition alone.

## RELATED LINKS

[Get-R1DataSourceType](Get-R1DataSourceType)

[New-R1DataSource](New-R1DataSource)
