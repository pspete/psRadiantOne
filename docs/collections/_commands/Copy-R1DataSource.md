---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Copy-R1DataSource

## SYNOPSIS
Copies a data source.

## SYNTAX

```
Copy-R1DataSource [-existingDataSource] <String> [-newDataSourceName] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a copy of an existing data source under a new name.

## EXAMPLES

### Example 1
```powershell
Copy-R1DataSource -existingDataSource 'opendj' -newDataSourceName 'opendj-test'
```

Copies the opendj data source.

### Example 2
```powershell
Copy-R1DataSource -existingDataSource 'advworks' -newDataSourceName 'advworks-test'
Get-R1DataSource -name 'advworks-test' | Test-R1DataSourceConnection -useExistingCredentials
```

Copies a data source and tests the copy. The stored password is copied too, so the copy connects
with -useExistingCredentials.

## PARAMETERS

### -existingDataSource
The name of the data source to copy.

```yaml
Type: String
Parameter Sets: (All)
Aliases: name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -newDataSourceName
The name to give the copy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

## RELATED LINKS

[Get-R1DataSource](Get-R1DataSource)

[New-R1DataSource](New-R1DataSource)
