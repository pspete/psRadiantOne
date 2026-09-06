# Unreleased

## Added

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

- Private HTTP and request-building plumbing shared by every command:
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
