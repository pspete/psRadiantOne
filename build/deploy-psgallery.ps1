<#---------------------------------
Auto-publish changes to main branch as a new module version in the PSGallery.
- Only publish if build version is greater than the configured gate ($env:release_version_gate)
- Skip Auto-publish with specific commit message of "Manual Deployment"

Requires this plain (non-secret) environment variable to be set in appveyor.yml:
  release_version_gate  - e.g. '0.1.0' for a new module, or '1.0.0' once it's past initial development
---------------------------------#>


if (-not ($ENV:APPVEYOR_PULL_REQUEST_NUMBER)) {

	<#---------------------------------#>
	<# If Not a PR                     #>
	<#---------------------------------#>
	If (($ENV:APPVEYOR_REPO_BRANCH -eq 'main') -and ($env:APPVEYOR_BUILD_VERSION -ge $env:release_version_gate)) {

		Write-Host 'Deploy Process: PowerShell Gallery' -ForegroundColor Yellow

		If ($ENV:APPVEYOR_REPO_COMMIT_MESSAGE -eq 'Manual Deployment') {

			<# Manual Deploy to PSGallery #>
			Write-Host "Finished testing of branch: $env:APPVEYOR_REPO_BRANCH" -ForegroundColor Cyan
			Write-Host 'Manual Deployment to PSGallery Required' -ForegroundColor Cyan
			Write-Host 'Exiting' -ForegroundColor Cyan
			exit

		} Else {

			<#---------------------------------#
			# Publish to PS Gallery            #
			#----------------------------------#>

			$ModulePath = Resolve-Path "..\Release\$($env:APPVEYOR_PROJECT_NAME)\$($env:APPVEYOR_BUILD_VERSION)"

			Write-Host "Publish $($env:APPVEYOR_PROJECT_NAME) $($env:APPVEYOR_BUILD_VERSION) to Powershell Gallery......" -NoNewline

			Try {

				Publish-Module -Path $ModulePath -NuGetApiKey $($env:psgallery_key) -SkipAutomaticTags -Confirm:$false -ErrorAction Stop -Force

				Write-Host 'OK' -ForegroundColor Green

			} Catch {

				Write-Host "Failed - $_." -ForegroundColor Red
				throw $_

			} Finally {
				exit
			}

		}

	} Else {

		<# No Deployment      #>

		Write-Host "Finished testing: $($env:APPVEYOR_PROJECT_NAME) $env:APPVEYOR_REPO_BRANCH ($($env:APPVEYOR_BUILD_VERSION)) - Exiting" -ForegroundColor Cyan
		exit

	}

} Else {

	Write-Host 'Skipping Deploy Process: PowerShell Gallery' -ForegroundColor Yellow

}
