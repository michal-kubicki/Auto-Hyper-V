#Requires -RunAsAdministrator

[CmdletBinding()]

#Let's gather some important information
param(

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$VMName,
    
    [parameter(Mandatory=$true)]
    [ValidateRange(1, [int64]::MaxValue)]
    [int64] $VMProcessorCount,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$ISOPath
)

#Set the switch name, HDD and memory size, number of CPU
$VMSwitchName = 'External Virtual Switch'
$VHDXSizeBytes = 10GB
$MemoryStartupBytes = 2GB
$VMProcessorCount = 2

#Get the default HDD path
$vmmsSettings = Get-WmiObject -namespace root\virtualization\v2 Msvm_VirtualSystemManagementServiceSettingData
$vhdxPath = Join-Path $vmmsSettings.DefaultVirtualHardDiskPath "$VMName.vhdx"

#Create new Hyper-V VM
New-VM -Name $VMName -Generation 2 -SwitchName $VMSwitchName -MemoryStartupBytes $MemoryStartupBytes -NewVHDPath $vhdxPath -NewVHDSizeBytes $VHDXSizeBytes

#VM Configure the new VM
Set-VMProcessor $VMName -Count $VMProcessorCount
Set-VMFirmware -VMName $VMName -EnableSecureBoot off

#Boot order
Add-VMDvdDrive -VMName $VMName -Path $ISOPath
$vmHardDiskDrive = Get-VMHardDiskDrive -VMName $VMName
$VMDvdDrive = Get-VMDvdDrive -VMName $VMName

Set-VMFirmware $VMName -BootOrder $VMDvdDrive, $vmHardDiskDrive