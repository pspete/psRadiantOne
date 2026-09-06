---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Get-R1FIDUser

## SYNOPSIS
Returns FID users.

## SYNTAX

### All (Default)
```
Get-R1FIDUser [-searchFilter <String>] [-pageSize <Int32>] [<CommonParameters>]
```

### Username
```
Get-R1FIDUser -username <String> [<CommonParameters>]
```

## DESCRIPTION
Returns the FID users configured on the RadiantOne deployment.

Specify a username to return a single user. When no username is specified, all users are returned;
the API pages this result and every page is retrieved automatically, so all matching users are
returned regardless of the page size.

## EXAMPLES

### Example 1
```powershell
Get-R1FIDUser
```

Returns all FID users.

### Example 2
```powershell
Get-R1FIDUser -username john_smith
```

Returns the named user.

### Example 3
```powershell
Get-R1FIDUser -searchFilter smith
```

Returns all users whose username or email contains "smith".

## PARAMETERS

### -pageSize
The number of entries requested from the API in a single page. All pages are retrieved and returned regardless of this value; it controls only how many entries each request asks for.

```yaml
Type: Int32
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -searchFilter
Case-insensitive filter returning only users whose username or email contains the specified value.

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -username
The username of the user to return. When omitted, all users are returned.

```yaml
Type: String
Parameter Sets: Username
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### psRadiantOne.FIDUser

## NOTES

## RELATED LINKS
