# .ExternalHelp psRadiantOne-help.xml
function Set-R1PasswordPolicy {
	#The API names these settings, not credentials: userMayChangePassword is a policy flag and
	#passwordEncryptionAlgorithm names an algorithm. Renaming them would break the request body.
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = 'Password policy settings, not credentials')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', 'passwordEncryptionAlgorithm', Justification = 'Names an encryption algorithm, not a password')]
	[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
	[OutputType([void])]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$policyName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet('GROUP', 'SUBTREE')]
		[string]$targetType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$targetDn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(1, 1000)]
		[int]$precedence,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$passwordMustChangeAfterReset,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$userMayChangePassword,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$requireExistingPasswordToChange,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$allowChangesInterval,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$passwordKeepHistory,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordHistorySize,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$passwordExpires,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordExpiresAfterInterval,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$warningBeforeExpirationInterval,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$graceLoginAttemptAfterExpiration,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$contentEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordMinLength,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordLeastNumChars,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordLeastLowerChars,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordLeastUpperChars,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordLeastSpecialChars,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$pwdQualityMinChangedChar,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$pwdEnableNotContainNames,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$passwordEncryptionAlgorithm,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$pwdEnableAlgorithmUpgrade,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$pwdPattern,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$enablePwdPolicyDictionarySubstringCheck,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$pwdEnableDictionary,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$passwordLockout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordLoginFailureCountBeforeLockout,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordResetFailureCountAfterMinutes,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordLockoutDuration,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[bool]$pwdEnableLastLogonTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordLastLogonTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateRange(0, [int]::MaxValue)]
		[int]$passwordIdleLockoutInterval
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		$URI = Resolve-R1ServiceUrl -Service Settings -Path 'password_policies/policy'

		#Retrieve the policy and send it back with the supplied values applied over it, so a setting
		#left unspecified keeps its current value.
		$Existing = Get-R1PasswordPolicy -policyName $policyName

		$Template = [ordered]@{
			name                                    = $policyName
			targetType                              = $null
			targetDn                                = $null
			precedence                              = 0
			passwordMustChangeAfterReset            = $false
			userMayChangePassword                   = $false
			requireExistingPasswordToChange         = $false
			allowChangesInterval                    = 0
			passwordKeepHistory                     = $false
			passwordHistorySize                     = 0
			passwordExpires                         = $false
			passwordExpiresAfterInterval            = 0
			warningBeforeExpirationInterval         = 0
			graceLoginAttemptAfterExpiration        = 0
			contentEnabled                          = $false
			passwordMinLength                       = 0
			passwordLeastNumChars                   = 0
			passwordLeastLowerChars                 = 0
			passwordLeastUpperChars                 = 0
			passwordLeastSpecialChars               = 0
			pwdQualityMinChangedChar                = 0
			pwdEnableNotContainNames                = $false
			passwordEncryptionAlgorithm             = $null
			pwdEnableAlgorithmUpgrade               = $false
			pwdPattern                              = $null
			enablePwdPolicyDictionarySubstringCheck = $false
			pwdEnableDictionary                     = $false
			passwordLockout                         = $false
			passwordLoginFailureCountBeforeLockout  = 0
			passwordResetFailureCountAfterMinutes   = 0
			passwordLockoutDuration                 = 0
			pwdEnableLastLogonTime                  = $false
			passwordLastLogonTime                   = 0
			passwordIdleLockoutInterval             = 0
		}

		$Request = Merge-R1Parameter -Template $Template -BoundParameter ($PSBoundParameters | Get-Parameter -ParametersToRemove policyName) -Fallback $Existing

		$Body = $Request | ConvertTo-R1JsonBody

		if ($PSCmdlet.ShouldProcess($policyName, 'Update Password Policy')) {

			$null = Invoke-R1RestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	End { }#end

}
