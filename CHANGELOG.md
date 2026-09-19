# Unreleased

## Added

- Read commands for the directory namespace configuration which had none:
  - Caches: `Get-R1Cache`, `Get-R1CacheProperty`, `Get-R1CacheRefresh`,
    `Get-R1CacheRealTimeConnector`, `Get-R1CacheRealTimeConnectorDiagnostic`,
    `Get-R1CacheRealTimeConnectorConfig` and `Get-R1CacheRealTimeConnectorType`. A cache pipes to
    the other cache commands by its label.
  - LDAP and database proxies: `Get-R1NamingContextLdapProxyBackend`,
    `Get-R1NamingContextLdapProxyAdvanced`, `Get-R1NamingContextMergedBackend` and
    `Get-R1NamingContextDbProxyProperty`.
  - Content, label and link nodes: `Get-R1NamingContextContentProperty`,
    `Get-R1NamingContextContentRdnAttribute`, `Get-R1NamingContextContentAdvanced`,
    `Get-R1NamingContextConfigurationParameter`, `Get-R1NamingContextLabelProperty`,
    `Get-R1NamingContextLinkProperty`, `Get-R1NamingContextLinkParameterTree`,
    `Get-R1NamingContextLinkParameterTreeAttribute` and `Get-R1NamingContextLinkParameterString`.
  - The object builder: `Get-R1PrimaryObject`, `Get-R1AvailablePrimaryObject`,
    `Get-R1SecondaryObject` and `Get-R1ComputedAttributeFunction`.
  - Directory stores: `Get-R1StoreProperty` and `Get-R1StoreBackup`.
  - `Get-R1NamingContextInterceptionScriptCode` and `Get-R1NamingContextReplication`.
- Format views listing caches, real time connectors and their types, computed attribute functions,
  content RDN attributes and link parameter attributes as tables.
- Commands which configure LDAP and database proxies:
  - `Mount-R1NamingContextBackend` mounts an LDAP directory or a database on a naming context node.
  - `Set-R1NamingContextLdapProxyBackend` and `Set-R1NamingContextLdapProxyAdvanced` update an
    LDAP proxy.
  - `Add-R1NamingContextMergedBackend` and `Remove-R1NamingContextMergedBackend` merge a second
    LDAP data source into an LDAP proxy, and remove it again.
  - `Set-R1NamingContextInterceptionScriptCode` replaces the interception script of a naming
    context.
- Commands which configure label and content nodes and the object builder:
  - `Set-R1NamingContextLabelProperty` updates a label node.
  - `Set-R1NamingContextContentProperty` and `Set-R1NamingContextContentAdvanced` update how a
    content or container node names and presents its entries.
  - `Set-R1SecondaryObject` saves the object model of a primary object, and `Get-R1RelatedObject`
    returns the objects related to it for adding to the model.
- Commands which build the parts of an object model in the object builder: `New-R1ObjectInputSource`,
  `New-R1ObjectExtension` and `New-R1JoinProfile` build input sources, extensions and joins,
  `New-R1ComputedAttributeExpression` builds a computed attribute expression from a function,
  `Test-R1ComputedAttributeExpression` checks that one compiles, and
  `Convert-R1ComputedAttributeExpression` rewrites expressions for a renamed attribute. Each returns
  its result for saving with `Set-R1SecondaryObject`.
- Commands which manage RadiantOne Directory stores: `Set-R1StoreProperty`, `Reset-R1StoreIndex`,
  `Backup-R1Store`, `Export-R1StoreBackup`, `Restore-R1Store` and `Import-R1StoreBackup`.
  `Mount-R1NamingContextBackend` mounts a store with `-Store`.
  `Import-R1StoreData` initializes a store from an LDIF file.
- Commands which create and manage persistent caches: `New-R1Cache`, `Set-R1CacheRefresh`,
  `Initialize-R1Cache`, `Set-R1CacheProperty` and `Import-R1Cache`, and for real time refresh
  `Set-R1CacheRealTimeConnectorConfig`, `Export-R1CacheRealTimeConnectorScript` and
  `Invoke-R1CacheRealTimeConnectorScript`. `Remove-R1Cache` deletes a cache.
- `New-R1NamingContextInterceptionScript` and `Set-R1NamingContextInterceptionScript` give a content
  node a new interception script, or one which already exists.

## Fixed

- `New-R1NamingContextContent` and `New-R1NamingContextContainer` always send
  `isQuoteTableNames`, `isQuoteColumnNames` and `isRelatedObjectsOnly`, as false unless
  specified. `isRelatedObjectsOnly` was previously left out unless given, and the API takes an
  absent value to be true.
- `Set-R1NamingContextContentAdvanced` clears a where clause when given an empty string, sending it
  as the control panel does. It sent null, which the API ignores.

# 0.3

## Added

- `Import-R1DataSource` takes `-overrideExisting`, `-performOpOnSchemas` and `-crossEnvironment`, and
  `Export-R1DataSource` the last two. An import is refused where the data source already exists
  unless `-overrideExisting` is given. Only the options supplied are sent.
- `New-R1DataSource` and `Set-R1DataSource` take `-sdcMappings`, the Secure Data Connector mappings
  the API defines for an LDAP or database data source.
- Format views for the types returned by the data catalog, directory namespace, administration and
  settings commands. Data sources, data source types, schemas, tables, fields, relationships, naming
  contexts, directory entries, views, users, roles, tasks, ACIs, feature flags, file manager
  directories and dashboard items are listed as tables rather than a page per object, and
  `Format-List` renders the nested permission, log and counter blocks which previously printed as
  `@{...}`. Dates display in local time. Nothing is lost: `Select-Object *` and `Format-List` still
  reach every property, including a task's log and an interception script's contents.

## Changed

- **`Set-R1DataSource` requires either `-password` or `-useExistingCredentials`.** They cannot be
  combined, and a call giving neither is refused. An existing call which updates a data source
  without setting a password needs `-useExistingCredentials` adding to it.
- `Get-R1FileManagerDirectory` returns the directory entries rather than the object which wraps
  them, so they can be filtered and piped. Each carries `uploadAllowed`, the flag the API returns
  for the directory listed.
- `-Path` is optional on `Export-R1DataSource`, `Export-R1DataSourceType`,
  `Export-R1DirectorySchemaFile`, `Export-R1File` and `Save-R1DirectoryLdif`, and takes a directory
  or the full path of a file. A download is saved under the name the API sends it with, or under the
  name the path ends in, and without a path to the current user's Downloads directory.

## Fixed

- The five export commands write a binary download intact. An archive had been written out as one
  decimal number per byte, so it could not be opened.
- A command no longer fails when the API answers a successful request with a message rather than
  JSON. The message is warned and returned.
- `Add-R1DataSourcePlugin` returns the staged import, which carries the id
  `Complete-R1DataSourceTypeImport` and `Remove-R1DataSourceTypeImport` act on.
- `Set-R1DataSource` keeps the stored password of an LDAP or database data source, which sending
  null had cleared, and leaves a null `groupId` or `kerberosProfile` as the API returned it.
- `Set-R1DataSource`, `New-R1DataSource`, `Set-R1DataSourceType` and `Set-R1SchemaFullObject` no
  longer send a collection holding nothing where the API returns null. One such record could not be
  read back, and made every later read of any data source fail.
- `Set-R1SchemaFullObject` sends the schema's `objects` back, which it had left out of the update.

# 0.2

## Fixed

- Commands which create an object no longer fail on PowerShell 7.4 and later.
- `Reset-R1DirectoryEntryPassword` sets a usable password. A password set by an earlier version
  cannot be authenticated with and must be set again.
- `Get-R1TaskLog` returns the last lines of a log rather than timing out and returning nothing.
  `-Tail` and `-TimeoutSec` are replaced by `-numberOfLines`, which the API expects and the command
  never sent. The whole log is returned as one line per string, as a tail already was.

## Changed

- `Import-R1DirectoryLdif` returns the task the import runs as, rather than its id alone.
- `Connect-R1Session` populates the `WebSession`, `Version` and `ElapsedTime` session properties.
- Secrets in a response are masked in the `LastCommandResults` session property.
- `Get-R1Session` returns an object rather than a dictionary, so `Select-Object` reads its
  properties, and prints without the token, the websession and the last response.

# 0.1

First release. Everything below is new, so the entries are grouped by the area of the RadiantOne API
they cover rather than split into added, changed and fixed.

## Added

### Session & authentication

- `Connect-R1Session` / `Disconnect-R1Session` / `Get-R1Session`, `Update-R1AuthToken` and
  `Reset-R1Password`. `-BaseURI` takes the API endpoint address, which on a cloud tenant is the
  control panel address with `/api` appended; both are listed in the EOC Application Endpoints panel.
  An expired password is surfaced by `Connect-R1Session` as the reset information the API returns,
  whose `resetToken` drives `Reset-R1Password`.
- `Disconnect-R1Session` takes `-Force` to clear the local session where the token could not be
  revoked. Revoking requires `SCOPE_AUTH_TOKEN_REVOKE`; without it the token stays valid, so by
  default the failure is reported and the session left in place, keeping the revocation retryable.
- `Test-R1AdapToken` and `Test-R1CallerPrivilege`.
- `Get-R1AccessToken`, `New-R1AccessToken`, `Remove-R1AccessToken`. The token value is returned only
  when it is created and cannot be retrieved again.

### Users, roles and the directory manager

- `Get-R1FIDUser`, `New-R1FIDUser`, `Set-R1FIDUser`, `Remove-R1FIDUser` and `Set-R1FIDUserRole`.
  `Get-R1FIDUser` follows the API's cursor pagination and returns every page. Roles may be supplied
  when creating or updating a user, which the API accepts despite the schema marking them read-only.
- `Get-R1FIDRole`, `New-R1FIDRole`, `Set-R1FIDRole`, `Remove-R1FIDRole`.
- `Get-R1DirectoryManager` / `Set-R1DirectoryManager`, `Get-R1SpecialGroup` / `Set-R1SpecialGroup`.

### Security settings

- Access control: `Get-R1AccessControlSetting` / `Set-R1AccessControlSetting`, `Get-R1Aci`,
  `New-R1Aci`, `Set-R1Aci`, `Remove-R1Aci`, `Get-R1AciLocation` and `Test-R1Aci`.
- Attribute encryption: `Get-R1AttributeEncryption` / `Set-R1AttributeEncryption`,
  `Get-R1AttributeEncryptionKmsSetting` / `Set-R1AttributeEncryptionKmsSetting` and
  `Update-R1AttributeEncryptionKey`.
- Client certificate truststore: `Get-R1TruststoreCertificate`, `Add-R1TruststoreCertificate`,
  `Remove-R1TruststoreCertificate` and `Export-R1TruststoreCertificate`.
- External token validators: `Get-R1TokenValidator`, `New-R1TokenValidator`, `Set-R1TokenValidator`
  and `Remove-R1TokenValidator`.
- OIDC providers: `Get-R1OidcProvider`, `New-R1OidcProvider`, `Set-R1OidcProvider`,
  `Remove-R1OidcProvider`, `Get-R1OidcLoginInfo`, `Get-R1OidcDiscoveryEndpoint`,
  `Get-R1OidcDiscoveryInfo` and `Get-R1OidcScopesClaim`.
- Audit logging: `Get-R1AuditLogSetting` / `Set-R1AuditLogSetting` and `Export-R1AuditLog`.
- Password policies: `Get-R1PasswordPolicy`, `Set-R1PasswordPolicy`, `Remove-R1PasswordPolicy`,
  `Get-R1PasswordDictionary`, `Add-R1PasswordDictionaryWord`, `Remove-R1PasswordDictionaryWord`,
  `Get-R1PasswordEncryption` and `Test-R1PasswordStrengthRule`.

### Platform settings

- Configuration pairs: `Get-`/`Set-R1ChangeLogSetting`, `Get-`/`Set-R1GlobalAttributeSetting`,
  `Get-`/`Set-R1LdapClientAccess`, `Get-`/`Set-R1LdapClientAccessMapping`,
  `Get-`/`Set-R1RestClientAccess`, `Get-`/`Set-R1ControlPanelConfiguration`,
  `Get-`/`Set-R1GlobalLimit`, `Get-`/`Set-R1AccessRegulationLimit`, `Get-`/`Set-R1BackendLimit`,
  `Get-`/`Set-R1CustomLimit` and `Get-`/`Set-R1Feature`.
- Log settings: `Get-R1LogSetting` / `Set-R1LogSetting`, addressing a component, a data source or a
  plugin, and `Get-R1LogTimezone`.
- Identity observability: `Get-`/`Set-R1PipelineConnectorConfig`, `Get-R1PipelineConnectorType`,
  `Reset-R1PipelineConnector`, `Suspend-R1Pipeline`, `Resume-R1Pipeline` and
  `Invoke-R1PipelineConnectorScript`.
- Entry statistics: `Get-R1Operation`, `New-R1Operation`, `Stop-R1Operation`, `Resume-R1Operation`
  and `Get-R1Statistic`.
- Licensing: `Get-R1License`, `Set-R1License` and `Read-R1License`.
- Deployment and dashboard readers: `Get-R1Dashboard`, `Get-R1DashboardLink`, `Get-R1ProductVersion`,
  `Get-R1ServiceSummary`, `Get-R1WhatsNew`, `Get-R1SaasConfiguration`, `Get-R1LoginPageInfo`,
  `Get-R1ControlPanelMessage`.

### Directory namespace

- Global namespace settings: `Get-R1GlobalInterceptionSetting` / `Set-R1GlobalInterceptionSetting`,
  `Get-R1GlobalSpecialAttribute` / `Set-R1GlobalSpecialAttribute` and `Get-R1GlobalDynamicGroup`.
- Naming contexts: `Get-R1NamingContext`, `Get-R1NamingContextChild`, `New-R1NamingContext`,
  `Remove-R1NamingContext`, `Enable-R1NamingContext` / `Disable-R1NamingContext`,
  `New-R1NamingContextLabel`, `New-R1NamingContextContent`, `New-R1NamingContextContainer` and
  `New-R1NamingContextLink`. The two list commands follow the offset pagination of the API and return
  every page. No total is reported by the API, so the end of a collection is recognised by a page
  holding fewer nodes than were asked for.
- Interception scripts: `Get-R1InterceptionScript`, `Import-R1InterceptionScript`,
  `Remove-R1InterceptionScript`, `Get-R1InterceptionScriptLibrary`,
  `Import-R1InterceptionScriptLibrary`, `Remove-R1InterceptionScriptLibrary`,
  `Get-R1GlobalInterceptionScript` / `Set-R1GlobalInterceptionScript`,
  `Test-R1InterceptionScriptCode` and `New-R1InterceptionScriptJar`. The two upload commands take a
  local file path and send it as multipart form data, which works on Windows PowerShell as well as
  PowerShell 7.
- Namespace utilities: `Test-R1LdapFilter`, `Test-R1ComputedAttributeName`,
  `Test-R1JoinCondition`, `Get-R1JoinCondition`, `Get-R1DynamicGroupFormat` and
  `Get-R1LinkedAttributeDefault`. The three Test commands return a boolean; where the API also
  reports why a value was rejected, that reason is written to the verbose stream.
- Naming context special attributes, virtual tree and relationship tree:
  `Get-R1NamingContextSpecialAttribute` / `Set-R1NamingContextSpecialAttribute`,
  `Get-R1NamingContextVirtualTreeProperty` / `Set-R1NamingContextVirtualTreeProperty` and
  `Get-R1NamingContextRelationshipTree`.
- Namespace views: `Get-R1NamespaceView` and `Remove-R1NamespaceView`.

### Directory schema

- Object classes: `Get-R1DirectoryObjectClass`, `New-R1DirectoryObjectClass`,
  `Set-R1DirectoryObjectClass`, `Remove-R1DirectoryObjectClass` and `Get-R1DirectoryObjectClassParent`.
- Attributes: `Get-R1DirectoryAttribute`, `New-R1DirectoryAttribute`, `Set-R1DirectoryAttribute`,
  `Remove-R1DirectoryAttribute` and `Get-R1DirectoryAttributeSyntax`. `Get-R1DirectoryAttribute`
  returns attribute names by default and full definitions when `-includeAllProperties` is specified,
  following the form the API reports in its response.
- Schema files: `Get-R1DirectorySchemaFile`, `Export-R1DirectorySchemaFile`,
  `Import-R1DirectorySchemaFile` and `Remove-R1DirectorySchemaFile`. Import takes either a local file,
  sent as multipart form data, or the name of a file already on the server.

### Data catalog

- Schemas: `Get-R1Schema`, `New-R1Schema`, `Set-R1Schema`, `Remove-R1Schema`,
  `Get-R1SchemaFullObject` / `Set-R1SchemaFullObject`, `Get-R1SchemaAssociatedView`,
  `New-R1GeneratedSchema`, `Get-R1PublishedSchema` and `Publish-R1Schema`.
  `Set-R1SchemaFullObject` updates a schema together with its tables, fields and relationships in one
  request. `Publish-R1Schema` replaces the whole published set, so a name left out is unpublished.
- Schema tables and relationships: `Get-R1SchemaTable`, `New-R1SchemaTable`, `Set-R1SchemaTable`,
  `Remove-R1SchemaTable`, `Add-R1SchemaTable`, `Get-R1SchemaTableField` / `Set-R1SchemaTableField`,
  `Get-R1SchemaRelationship`, `New-R1SchemaRelationship`, `New-R1RecursiveSchemaRelationship`,
  `Set-R1SchemaRelationship`, `Remove-R1SchemaRelationship`, `Get-R1SchemaRelationshipTree`,
  `Merge-R1SchemaObject` and `New-R1SchemaDerivedView`. `Add-R1SchemaTable` appends tables by name;
  `Set-R1SchemaTableField` replaces the whole field collection.
- Data sources: `Get-R1DataSource`, `New-R1DataSource`, `Set-R1DataSource`, `Remove-R1DataSource`,
  `Copy-R1DataSource`, `Search-R1DataSource`, `Test-R1DataSourceConnection`, `Get-R1DataSourceObject`,
  `Get-R1DataSourceTable`, `Get-R1DataSourceGroup`, `Add-R1DataSourceSchemaLink`,
  `Remove-R1DataSourceSchemaLink`, `Import-R1DataSource` and `Export-R1DataSource`.
  `New-R1DataSource` has a parameter set per kind of source: LDAP, database and custom.
  The API does not return the bind password, so `Set-R1DataSource` sends null rather than the empty
  string it reads back, which the API documents as leaving the stored password alone. Supply
  `-password` to change it, or `-useExistingCredentials` to keep every stored password.
- Data source types and plugins: `Get-R1DataSourceType`, `New-R1DataSourceType`,
  `Set-R1DataSourceType`, `Remove-R1DataSourceType`, `Test-R1DataSourceType`,
  `Get-R1DataSourcePlugin`, `Add-R1DataSourcePlugin`, `Remove-R1DataSourcePlugin`,
  `Get-R1DataSourcePluginLibrary` / `Set-R1DataSourcePluginLibrary`, `Get-R1DataSourcePluginClass`,
  `Import-R1DataSourceType`, `Get-R1DataSourceTypeImport`, `Complete-R1DataSourceTypeImport`,
  `Remove-R1DataSourceTypeImport`, `Get-R1DataSourceTypeImportMeta`,
  `New-R1DataSourceTypeImportMeta`, `Set-R1DataSourceTypeImportMeta`,
  `Remove-R1DataSourceTypeImportMeta` and `Export-R1DataSourceType`.
  Types do not all carry the same properties, so `Set-R1DataSourceType` builds its request from what
  the API returned rather than from a fixed list. Uploading templates creates a session which is then
  inspected, imported or discarded.
- Libraries: `Get-R1Library`, `Search-R1Library`, `Import-R1Library`, `Set-R1Library`,
  `Remove-R1Library`, `Clear-R1Library`, `Get-R1LibraryDependency` / `Set-R1LibraryDependency` and
  `Get-R1LibraryDependent`.
- JDBC drivers: `Get-R1JdbcDriverFile`, `Import-R1JdbcDriver`, `Remove-R1JdbcDriver` and
  `Get-R1JdbcDriverLibrary` / `Set-R1JdbcDriverLibrary`.
- Data migration: `Get-R1MigrationPlan`, `New-R1MigrationPlan`, `Get-R1MigrationStatus`,
  `Get-R1MigrationLog`, `Get-R1MigrationExport`, `Export-R1MigrationData`, `Stop-R1Migration` and
  `Clear-R1Migration`. Only `Get-R1MigrationStatus` answers when no operation is running; the others
  report an error, so check the status first.
- Private files: `Import-R1PrivateFile` and `Remove-R1PrivateFile`.
- Data preview: `Get-R1LdapDataPreview`, which reads from an LDAP source without creating a schema.
- Schema comparison: `Compare-R1Schema` returns the differences between a schema and its data source,
  and `Invoke-R1SchemaDiff` applies them, either updating the schema or saving the result as a new one.

### Directory browser

- Entries: `Get-R1DirectoryEntry`, `New-R1DirectoryEntry`, `Set-R1DirectoryEntry`,
  `Remove-R1DirectoryEntry`, `Rename-R1DirectoryEntry`, `Move-R1DirectoryEntry` and
  `Reset-R1DirectoryEntryPassword`. `Get-R1DirectoryEntry` both browses and searches: supply a filter
  and a scope to search, and it follows the cursor until every page has been read.
- Group membership: `Get-R1DirectoryEntryMember`, `Set-R1DirectoryEntryMember` and
  `Search-R1DirectoryEntryMember`. Explicit membership by default, dynamic with `-Dynamic`.
- Saved searches: `Get-R1DirectorySearchInfo` / `Set-R1DirectorySearchInfo`, which store the search
  tabs and history the control panel shows rather than performing a search.
- LDIF: `Export-R1DirectoryLdif` writes to the server, `Save-R1DirectoryLdif` downloads,
  `Import-R1DirectoryLdif` takes a local or a server file, `Get-R1DirectoryLdifFile` and
  `Remove-R1DirectoryLdifFile` manage what is stored.
- `Test-R1DirectoryAuthentication` and `Close-R1DirectoryPagedSearch`.

### Task management

- Scheduler: `Get-R1TaskScheduler` / `Set-R1TaskScheduler`, `Start-R1TaskScheduler`,
  `Stop-R1TaskScheduler` and `Restart-R1TaskScheduler`.
- Tasks: `Get-R1Task`, `Set-R1Task`, `Remove-R1Task`, `Start-R1Task`, `Stop-R1Task`,
  `New-R1CustomTask` and `Get-R1TaskLog`.
  `Get-R1TaskLog -Tail` follows a running log, and the endpoint does not close the response when it
  reaches the end, so the request is bounded by `-TimeoutSec` and returns what arrived within it.
  `New-R1CustomTask` uploads a compiled class and a properties file together.

### Configuration promotion and the file manager

- Promotion: `Get-R1PromotionState`, `Get-R1PromotionSetting`, `Start-R1PromotionStaging`,
  `Get-R1PromotionStagedResource`, `Test-R1PromotionStagedResource`, `Clear-R1PromotionStaging`,
  `Export-R1Configuration`, `Import-R1Configuration`, `Get-R1ConfigurationExportReport` and
  `Get-R1ConfigurationImportReport`. `Import-R1Configuration -apply $false` is a dry run.
- File manager: `Get-R1FileManagerDirectory`, `New-R1FileManagerDirectory`,
  `Remove-R1FileManagerDirectory`, `Rename-R1FileManagerDirectory`, `Get-R1FileContent`,
  `Set-R1FileContent`, `Import-R1File`, `Export-R1File`, `Remove-R1File` and `New-R1Jar`.
- `Reset-R1DashboardLink`, which restores the default dashboard links.

## Notes

These are the behaviours worth knowing before using the module, rather than a record of changes.

- **Updates read before they write.** The RadiantOne update endpoints replace the resource rather
  than merging into it: a property absent from the request is cleared, and a permission absent from a
  role resets to NONE, with the API returning 200 either way. Every `Set-*` command issuing a PUT
  therefore retrieves the resource first and sends it back with the supplied values applied over it,
  so a property left unspecified keeps its current value. Two consequences: those commands issue two
  requests, and the account needs permission to read the resource as well as to change it. A test
  enforces this and requires a written reason for each of the few commands exempt from it.
- **Some commands replace a whole collection.** `Set-R1FIDUserRole`, `Set-R1LdapClientAccessMapping`
  and `Set-R1CustomLimit` take the complete collection, so anything omitted is removed. Their help
  says so, and `Set-R1Feature` avoids the trap by retrieving every flag and changing only those named.
- **Secrets are sent as UTF8 bytes**, not as strings, so Windows PowerShell parameter binding and
  module logging cannot capture the plaintext.
- **Sixteen commands have not been exercised against a live deployment** and say so in their help,
  each with the reason: the endpoint is absent on a SaaS tenant (licensing), no account available
  could read it (backend limits, log settings), nothing was configured to read (token validators), or
  exercising it risked unrecoverable damage (attribute encryption, key rotation, the directory
  manager password).
- **`PUT /settings-service/oidc_providers` is deliberately not exposed.** It replaces the entire
  collection of providers with the array supplied, deleting any provider left out of it.
  `Set-R1OidcProvider` addresses a single provider instead.
