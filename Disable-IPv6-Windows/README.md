# 🛑 Disable IPv6 on Windows via PowerShell

This PowerShell script disables IPv6 on a Windows system both system-wide and on all active network adapters.

---

## ⚠️ Disclaimer

> Disabling IPv6 can cause certain features to malfunction, including:
> - HomeGroup
> - DirectAccess
> - Exchange / Outlook integration
> - Some Microsoft services  
> Proceed with caution. **A reboot is required** after running the script.

---

## 📂 Files

- `disable_IPv6.ps1` — Main PowerShell script
- `README.md` — This documentation file

---

## ✅ Features

- Disables IPv6 via `DisabledComponents` registry key
- Disables IPv6 binding (`ms_tcpip6`) on all active hardware adapters
- Outputs status messages for each step

---

## 💡 How to Use

### 1. Download the Script

Clone this repo or download `disable_IPv6.ps1` directly to your system.

```bash
git clone https://github.com/yourusername/disable-ipv6
cd disable-ipv6
Or manually place the file in a known folder (e.g. Downloads).

2. Unblock the Script
Option A: File Explorer
Right-click the .ps1 file → Properties

Check Unblock at the bottom (if present)

Click OK

Option B: PowerShell
powershell
Copy
Edit
Unblock-File -Path ".\disable_IPv6.ps1"
3. Run the Script as Administrator
Open PowerShell as Administrator, then run:

powershell
Copy
Edit
Set-ExecutionPolicy Bypass -Scope Process -Force
.\disable_IPv6.ps1
4. Restart Your PC
A full system reboot is required for the registry changes to take effect.

🔁 Re-enable IPv6
If you wish to undo the changes:

1. Remove the Registry Key
powershell
Copy
Edit
Remove-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents"
2. Re-enable IPv6 Bindings
powershell
Copy
Edit
Enable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6
Replace * with a specific adapter name if needed (e.g. "Ethernet").

3. Restart the System
🧰 Requirements
Windows 10 / 11

PowerShell 5.1+

Administrator privileges

🛡️ Execution Policy Notes
If PowerShell blocks script execution:

Temporary Bypass:
powershell
Copy
Edit
Set-ExecutionPolicy Bypass -Scope Process -Force
Allow Local Scripts Permanently:
powershell
Copy
Edit
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
To revert to default:

powershell
Copy
Edit
Set-ExecutionPolicy Restricted -Scope CurrentUser
