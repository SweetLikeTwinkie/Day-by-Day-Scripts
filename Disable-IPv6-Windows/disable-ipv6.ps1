<#
.SYNOPSIS
    Disables IPv6 on all network adapters on a Windows PC.

.DESCRIPTION
    This script does two things:
    1. Sets the DisabledComponents registry value to disable IPv6 system-wide.
    2. Disables the IPv6 binding on all active network adapters.
    A system reboot is required for the changes to take effect fully.

.NOTES
    File Name: Disable-IPv6.ps1
    Run As:    Administrator
#>

# Ensure the script is running as Administrator
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator."
    Exit 1
}

Write-Host "`n--- Disabling IPv6 via Registry (DisabledComponents) ---`n"

# Registry path for Tcpip6 parameters
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$regName = "DisabledComponents"
$regValue = 0xFFFFFFFF

try {
    New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType DWord -Force | Out-Null
    Write-Host "Successfully set 'DisabledComponents' to 0xFFFFFFFF in the registry."
} catch {
    Write-Host "ERROR: Failed to set the registry key for disabling IPv6. $_"
    Exit 1
}

Write-Host "`n--- Disabling IPv6 Bindings on Network Adapters ---`n"

try {
    # Get all network adapters that are not virtual or disconnected
    $netAdapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.HardwareInterface -eq $true }

    foreach ($adapter in $netAdapters) {
        Write-Host "Disabling IPv6 binding on: $($adapter.Name)"
        Disable-NetAdapterBinding -Name $adapter.Name -ComponentID ms_tcpip6 -Confirm:$false -ErrorAction Continue
    }

    Write-Host "`nIPv6 bindings disabled on all active adapters."
} catch {
    Write-Host "ERROR: Failed to disable IPv6 bindings. $_"
}

Write-Host "`nA reboot is required for the changes to take full effect."
Write-Host "Please restart your computer now."
