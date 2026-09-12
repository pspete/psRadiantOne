<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.INPUTS

.OUTPUTS
#>
[CmdletBinding()]
param(

	[bool]$DotSourceModule = $false

)

# If this module has a hard dependency on a companion module for shared private helpers
# (the pattern IdentityCommand.SCA/.SIA use with IdentityCommand), add that block here,
# after the primary loader below and before the session object is created. See the
# "Companion-module pattern" section in powershell.md for the exact snippet - don't
# duplicate the $Module = Get-Module -Name <DependencyModule> assignment if you copy it in.

#Get function files
Get-ChildItem $PSScriptRoot\ -Recurse -Include '*.ps1' -Exclude '*.ps1xml' |

	ForEach-Object {

		if ($DotSourceModule) {
			. $_.FullName
		} else {
			$ExecutionContext.InvokeCommand.InvokeScript(
				$false,
				(
					[scriptblock]::Create(
						[io.file]::ReadAllText(
							$_.FullName,
							[Text.Encoding]::UTF8
						)
					)
				),
				$null,
				$null
			)

		}

	}

# Script scope session object for session data
$Script:psRadiantOneSession = [ordered]@{
	BaseURI            = $null
	User               = $null
	Token              = $null
	TokenExpiry        = $null
	Privileges         = $null
	Organization       = $null
	Version            = $null
	WebSession         = $null
	StartTime          = $null
	ElapsedTime        = $null
	LastCommand        = $null
	LastCommandTime    = $null
	LastCommandResults = $null
	LastError          = $null
	LastErrorTime      = $null
} | Add-CustomType -Type psRadiantOne.Session

New-Variable -Name psRadiantOneSession -Value $Script:psRadiantOneSession -Scope Script -Force
