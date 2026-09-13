# .ExternalHelp psRadiantOne-help.xml
function Get-R1TaskLog {
	[CmdletBinding(DefaultParameterSetName = 'Download')]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$id,

		[parameter(
			Mandatory = $true,
			ParameterSetName = 'Tail'
		)]
		[switch]$Tail,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'Tail'
		)]
		[ValidateRange(1, 3600)]
		[int]$TimeoutSec = 30
	)

	Begin {

		Assert-R1Session -RequireToken

	}#begin

	Process {

		if ($Tail) {

			$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path "tasks/$($id | Get-EscapedString)/logs/tail"

			#The tail endpoint follows a running log and does not close the response on its own, so
			#the request is bounded by a timeout rather than waiting for the server to finish.
			$Result = Invoke-R1RestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec

		} else {

			$URI = Resolve-R1ServiceUrl -Service SysAdmin -Path "tasks/$($id | Get-EscapedString)/logs"

			$Result = Invoke-R1RestMethod -Uri $URI -Method GET

		}

		if ($null -ne $Result) {

			$Result

		}

	}#process

	End { }#end

}
