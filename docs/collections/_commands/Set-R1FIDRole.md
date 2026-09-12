---
external help file: psRadiantOne-help.xml
Module Name: psRadiantOne
online version:
schema: 2.0.0
---

# Set-R1FIDRole

## SYNOPSIS
Updates a FID role.

## SYNTAX

```
Set-R1FIDRole [-name] <String> [[-entryDn] <String>] [[-directoryBrowserPermission] <String>]
 [[-directoryNamespacePermissions] <Hashtable>] [[-identityManagerPermission] <String>]
 [[-securityPermissions] <Hashtable>] [[-classicControlPanelPermission] <Hashtable>]
 [[-tasksPermission] <String>] [-settingsPermissions <Hashtable>] [-tuningPermissions <Hashtable>]
 [[-globalSyncPermission] <String>] [[-observabilityPermission] <String>] [[-dashboardPermission] <String>]
 [[-fileManagerPermission] <String>] [[-revokeTokenPermission] <Boolean>]
 [[-dataCatalogPermissions] <Hashtable>] [[-administrationPermissions] <Hashtable>]
 [[-exportImportPermissions] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing FID role.

Any permission left unspecified defaults to NONE, so a complete set of the permissions the role
should hold must be supplied.

## EXAMPLES

### Example 1
```powershell
Set-R1FIDRole -name engineering -tasksPermission EDIT -dashboardPermission VIEW
```

Updates the permissions held by the named role.

## PARAMETERS

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

### -administrationPermissions
Hashtable of administration permissions, with userManagementPermission, entryStatisticsPermission, rolesPermission, directoryManagerPermission, controlPanelConfigPermission, accessTokensPermission, licensePermission, auditLoggingPermission, featureManagementPermission, maintenanceModePermission keys.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -classicControlPanelPermission
Hashtable describing access to the classic control panel, with enabled and assumeRole keys.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dashboardPermission
Permission granted over the dashboard. NONE, VIEW or EDIT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: NONE, VIEW, EDIT

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dataCatalogPermissions
Hashtable of data catalog permissions, with dataSourcesPermission, dataSourceOverrides, templateManagementPermission, globalRelationshipsPermission and dataAssessmentPermission keys.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -directoryBrowserPermission
Permission granted over the directory browser. NONE, VIEW or EDIT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: NONE, VIEW, EDIT

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -directoryNamespacePermissions
Hashtable of directory namespace permissions, with namespaceDesignPermission and directorySchemaPermission keys.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -entryDn
The DN of the directory entry the role is associated with.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -exportImportPermissions
Hashtable of configuration export/import permissions, with exportEnabled and importEnabled keys.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -fileManagerPermission
Permission granted over the file manager. NONE, VIEW or EDIT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: NONE, VIEW, EDIT

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -globalSyncPermission
Permission granted over global sync. NONE, VIEW or EDIT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: NONE, VIEW, EDIT

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -identityManagerPermission
Permission granted over the identity manager. NONE, VIEW or EDIT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: NONE, VIEW, EDIT

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of the role to update.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -observabilityPermission
Permission granted over identity observability. NONE, VIEW or EDIT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: NONE, VIEW, EDIT

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -revokeTokenPermission
Whether the role permits revoking authentication tokens.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -securityPermissions
Hashtable of security permissions, with attributeEncryptionPermission, accessControlPermission, passwordPoliciesPermission keys.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tasksPermission
Permission granted over tasks. NONE, VIEW or EDIT.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: NONE, VIEW, EDIT

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -settingsPermissions
Hashtable of settings permissions, with clientProtocolsPermission, clientCertificatePermission, tuningPermission, tokenValidatorPermission keys.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tuningPermissions
Hashtable of tuning permissions, with backendLimitsPermission, accessRegulationLimitsPermission, changeLogPermission, globalLimitsPermission, customLimitsPermission, globalAttributesPermission, logSettingsPermission keys.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Collections.Hashtable

### System.Boolean

## OUTPUTS

### System.Void

## NOTES

## RELATED LINKS
