---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Import-R1JdbcDriver

## SYNOPSIS
Uploads a JDBC driver.

## SYNTAX

```
Import-R1JdbcDriver [-Path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Uploads a JDBC driver jar and returns the driver classes found in it.

## EXAMPLES

### Example 1
```powershell
Import-R1JdbcDriver -Path .\\postgresql-42.jar
```

Uploads a driver.

### Example 2
```powershell
(Import-R1JdbcDriver -Path .\\postgresql-42.jar).classNames | Test-R1DataSourceType
```

Uploads a driver and checks whether its classes are loaded.

## PARAMETERS

### -Path
The path of the local file to upload.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FullName

Required: True
Position: 1
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

### psRadiantOne.DriverFileClassName

## NOTES

Nothing of this kind was configured on the deployment used while building the module, so the
behaviour of this command rests on the published API definition alone.

## RELATED LINKS

[Get-R1JdbcDriverFile](Get-R1JdbcDriverFile)

[Test-R1DataSourceType](Test-R1DataSourceType)
