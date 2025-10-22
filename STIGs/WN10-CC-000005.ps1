<#
.SYNOPSIS
    This PowerShell script prevents the camera from operating on a locked screen.

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-22
    Last Modified   : 2025-10-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 
#>
# WN10-CC-000005: Prevent enabling lock screen camera = Enabled
# Run as Administrator

$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
$name = 'NoLockScreenCamera'
$desired = 1

# Make sure the key exists
if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

# Get the current value (if it exists)
$current = (Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue).$name

# Apply change if needed
if ($current -ne $desired) {
    New-ItemProperty -Path $path -Name $name -Value $desired -PropertyType DWord -Force | Out-Null
    Write-Host "Set $name to $desired at $path"
} else {
    Write-Host "Compliant: $name already $desired"
}

# Verify
(Get-ItemProperty -Path $path -Name $name).$name
