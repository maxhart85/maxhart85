<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-09-09
    Last Modified   : 2025-09-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000500.ps1 
#>

# YOUR CODE GOES HERE

# Run in an elevated PowerShell
$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'

# Create the key if it doesn't exist
New-Item -Path $path -Force | Out-Null

# Set MaxSize = 0x00008000 (DWORD)  ->  32,768 KB (32 MB)
New-ItemProperty -Path $path -Name 'MaxSize' -PropertyType DWord -Value 0x00008000 -Force | Out-Null

# (Optional) Apply policy immediately
gpupdate /target:computer /force

# Verify
Get-ItemProperty -Path $path | Select-Object MaxSize
