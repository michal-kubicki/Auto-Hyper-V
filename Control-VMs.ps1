#Requires -RunAsAdministrator

[CmdletBinding()]

#Let's gather some important information
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$action
)

if ($action -eq "start") {

    #Get the names of all stopped VMs. Replace "localhost" with the Hyper-V server name if needed.
    $offVM = Get-VM -ComputerName localhost | Where-Object { $_.State -eq 'Off' }

    #Start each VM.
    foreach ($VM in $offVM) {
        Start-VM $VM.name
    }
}

elseif ($action -eq "stop") {
    #Get the names of all running VMs. Replace "localhost" with the Hyper-V server name if needed.
    $runningVM = Get-VM -ComputerName localhost | Where-Object { $_.State -eq 'Running' }

    #Stop each VM.
    foreach ($VM in $runningVM) {
        Stop-VM $VM.name -Force
    }
    Get-VM
}