# Disable IPv6 on Windows via PowerShell

## Overview

This PowerShell script disables IPv6 on a Windows machine by:
1. Configuring the registry to disable IPv6 system-wide.
2. Disabling the IPv6 binding (`ms_tcpip6`) on all active network adapters.

A system **reboot** is required to apply the changes.

---

## Prerequisites

- Windows 10 or Windows 11.
- PowerShell 5.1 or later.
- Administrator privileges.

---

## Installation

Clone the repository or download the scripts directly:

```bash
git clone https://github.com/yourusername/disable-ipv6.git
cd disable-ipv6
```

Alternatively, download `disable_IPv6.ps1` into your preferred directory.

---

## Usage

1. **Unblock the script (if required)**  
   ```powershell
   Unblock-File -Path ".\disable_IPv6.ps1"
   ```

2. **Execute the script as Administrator**  
   Open an elevated PowerShell prompt and run:  
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   .\disable_IPv6.ps1
   ```

3. **Reboot the system**  
   Restart your computer to complete the IPv6 disable process.

---

## Reverting Changes

To re-enable IPv6, perform the following steps:

1. **Remove the registry modification**  
   ```powershell
   Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents"
   ```

2. **Re-enable IPv6 adapter binding**  
   ```powershell
   Enable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6
   ```

3. **Reboot the system** to restore IPv6 functionality.


---
