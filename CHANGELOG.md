# Unreleased

## Added

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
