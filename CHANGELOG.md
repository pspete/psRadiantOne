# Unreleased

## Added

- Attribute encryption commands: `Get-R1AttributeEncryption` / `Set-R1AttributeEncryption`,
  `Get-R1AttributeEncryptionKmsSetting` / `Set-R1AttributeEncryptionKmsSetting`, and
  `Update-R1AttributeEncryptionKey`. The KMS retrieval reports only whether credentials are stored,
  so `Set-R1AttributeEncryptionKmsSetting` carries forward the region and alias and takes
  `-useExistingCredentials` to keep the stored credentials. None have been exercised against a live
  deployment: changing attribute encryption or rotating a key risks unreadable data.
- Client certificate truststore commands: `Get-R1TruststoreCertificate`,
  `Add-R1TruststoreCertificate`, `Remove-R1TruststoreCertificate` and
  `Export-R1TruststoreCertificate`. The import is multipart form data, the export a binary download.
- Access control commands, covering the `settings-service` access control and ACI endpoints:
  - `Get-R1AccessControlSetting` / `Set-R1AccessControlSetting`
  - `Get-R1Aci`, `New-R1Aci`, `Set-R1Aci`, `Remove-R1Aci`
  - `Get-R1AciLocation`, and `Test-R1Aci`, which reports whether an ACI can be parsed
  The ACI endpoints take the holding `baseDn` as a query parameter, required everywhere except when
  listing. The shapes of `AccessControl` and `Aci` were confirmed against a live 8.5 tenant.

- Session and authentication commands, covering the RadiantOne `authentication-service`:
  - `Connect-R1Session` / `Disconnect-R1Session` / `Get-R1Session`, `Update-R1AuthToken` and
    `Reset-R1Password`. An expired password is surfaced by `Connect-R1Session` as the password reset
    information returned by the API, whose `resetToken` drives `Reset-R1Password`.
  - `Test-R1AdapToken` and `Test-R1CallerPrivilege`.
  - `Get-R1AccessToken`, `New-R1AccessToken`, `Remove-R1AccessToken`.
  - `Get-R1FIDUser`, `New-R1FIDUser`, `Set-R1FIDUser`, `Remove-R1FIDUser`, `Set-R1FIDUserRole`.
    `Get-R1FIDUser` follows the API's cursor pagination and returns every page.
  - `Get-R1FIDRole`, `New-R1FIDRole`, `Set-R1FIDRole`, `Remove-R1FIDRole`.
  - `Get-R1DirectoryManager`, `Set-R1DirectoryManager`, `Get-R1SpecialGroup`, `Set-R1SpecialGroup`.
- Command help under `docs/collections/_commands`, and the generated `psRadiantOne-help.xml`.
- `Invoke-R1RestMethod` accepts `SslProtocol`, passed through to `Invoke-WebRequest` for an endpoint
  requiring a specific TLS protocol. PowerShell Core only.

## Fixed

- `Set-R1DirectoryManager` sends `username`, the property name a live 8.5 tenant returns, rather than
  the `userName` the published schema documents. Both operations share one schema, so the update
  takes the same name the retrieval returns. It also retrieves the current settings and sends them
  back with the supplied values applied over them, so the allowed IP list is no longer cleared when
  it is not specified, and `-username` is now optional. This command remains unexercised against a
  live deployment.

- `New-R1AccessToken` formats `expiresOn` with the invariant culture. ":" in a custom format string
  is the culture's time separator, so under a culture which does not use a colon - Finnish, for one -
  the timestamp was emitted as `2027-09-12T17.42.49.987Z` and rejected, leaving the expiry
  unsettable. The format itself is confirmed correct against a control panel request.

- `New-R1FIDRole` and `Set-R1FIDRole` send the role permissions the API actually accepts. Confirmed
  against a control panel request captured from a live 8.5 tenant, where the spec proved wrong:
  - `settingsPermission`, documented as a single NONE/VIEW/EDIT value, does not exist. The API takes
    `settingsPermissions`, an object of `clientProtocolsPermission`, `clientCertificatePermission`,
    `tuningPermission` and `tokenValidatorPermission`. A role created with the documented property
    silently lost its settings permissions.
  - `tuningPermissions` is absent from the spec and could not be set at all.
  - `securityPermissions` also takes `passwordPoliciesPermission`, and `administrationPermissions`
    also takes `auditLoggingPermission` and `featureManagementPermission`.
- `Set-R1FIDRole` retrieves the role before updating it and sends the complete role back, so a
  permission left unspecified keeps its current value. The endpoint resets any permission absent
  from the request to NONE, so updating one permission previously cleared every other permission the
  role held. Set a permission to NONE explicitly to clear it. The command now issues a GET followed
  by a PUT.
- `Set-R1FIDUser` accepts `-roles`, and retrieves the user before updating it so that a property
  left unspecified keeps its current value. The control panel sends back the complete object it
  retrieved; sending only the supplied properties risked clearing the rest, since the endpoint is a
  PUT of the whole user. The command now issues a GET followed by a PUT.
- `New-R1FIDUser` accepts `-roles`. The schema marks roles read-only and points at the deprecated
  roles endpoint, but the control panel sends them when creating a user and the API returns 201, so
  a user can be created with its roles in one call.

- `Invoke-R1RestMethod` reports the HTTP status when a failed request returns no response body.
  A null `ErrorDetails` parsed as valid JSON, so nothing populated the message and the error surfaced
  empty, naming neither the request nor the status.
- `Disconnect-R1Session` gains `-Force`, clearing the local session even where the token could not
  be revoked. Revoking requires `SCOPE_AUTH_TOKEN_REVOKE`, granted by a role holding
  `revokeTokenPermission`; a token which was not revoked is still valid, so by default the failure
  is reported and the session left in place, keeping the revocation retryable.

## Changed

- A `Set-*` command issuing a PUT now retrieves the resource first and sends it back complete, with
  the caller's values applied over it. The RadiantOne update endpoints replace rather than merge, so
  sending only the supplied properties silently cleared everything else. This is enforced by the
  `ReadModifyWrite` test, which fails any public command containing `-Method PUT` that does not use
  `Merge-R1Parameter`, unless it is listed as exempt with a reason. Exempt: `Update-R1AuthToken`, a
  bodyless action, and `Set-R1FIDUserRole`, whose body is the complete collection by definition.
- `Set-R1SpecialGroup` takes both group DNs as optional, so either can be set without restating the
  other.


- `Invoke-R1RestMethod` no longer pins TLS 1.2 on PowerShell Core. `WebSslProtocol` is a flags enum,
  so pinning `Tls12` permitted TLS 1.2 alone and excluded TLS 1.3; the connection now negotiates the
  strongest protocol both ends support.
- `Invoke-R1RestMethod` leaves a `SystemDefault` security protocol untouched under Windows PowerShell
  rather than replacing it with TLS 1.2 only, and combines TLS 1.2 with the protocols already
  permitted rather than overwriting them. The previous behaviour downgraded a correctly configured
  process, and could strip TLS 1.3 from one that had it enabled.

- Private HTTP and request-building plumbing shared by every command:
  - `ConvertTo-R1Timestamp` - formats a datetime as the UTC timestamp the API expects, with the
    invariant culture.
  - `Invoke-R1RestMethod` - the module's single HTTP entry point, sending the session token as a
    bearer token and translating RadiantOne `ClientError` responses into terminating errors.
  - `Resolve-R1ServiceUrl` - composes request URLs for each of the seven RadiantOne service prefixes.
  - `Get-R1Response` - returns JSON responses as objects, leaving file downloads untouched.
  - `ConvertTo-R1JsonBody` / `ConvertTo-R1SecretBody` - array-safe request body serialisation, with
    UTF8 byte output for bodies carrying a secret.
  - `Get-R1TokenClaim` - decodes the claims of a RadiantOne authentication token.
  - `Assert-R1Session` - reports an absent session rather than failing on a null base URL.
  - `Merge-R1Parameter`, `Get-Parameter`, `Get-EscapedString`, `ConvertTo-QueryString`,
    `ConvertTo-MultipartFormData`, `ConvertTo-InsecureString`, `Hide-SecretValue`,
    `Get-ParentFunction`, `Get-SessionClone`.
- Session object fields for the authentication token and its claims: `Token`, `TokenExpiry`,
  `Privileges`, `Organization`, `Version`.
