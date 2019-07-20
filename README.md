# Auto-Hyper-V
Automate the Hyper-V Virtual Machine deployment with PowerShell.

## Description

This is a simple PowerShell script for quick VM deployment. It takes three parameters: VMName, VMProcessorCount and ISOPath. If the specified number of CPU / cores exceeds available cores it will be reduced to the number of available cores.

The script will create a new VM with predefined memory, CPU / cores. Specified ISO image and a predefined switch will be attached. Have a look at the config section and set the desired values for:

```$VMSwitchName```

```$VHDXSizeBytes```

```$MemoryStartupBytes```

The boot order will be set to: DVD, HDD so you can proceed to install an OS.

## Usage
```New-Generic-VM.ps1 Ubuntu 4 d:\ubuntu-18.04.2-live-server-amd64.iso```

will create a new VM named Ubuntu with 2GB of RAM and 4 CPU / cores. The VM will boot from ubuntu-18.04.2-live-server-amd64.iso.