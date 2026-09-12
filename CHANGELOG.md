# Unreleased

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
