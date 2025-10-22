<#
.SYNOPSIS
    This PowerShell script sets the "NoLockScreenSlideShow" to "Enabled", or "1".

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-21
    Last Modified   : 2025-10-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 
#>
    
# WN10-CC-000010: Prevent enabling lock screen slide show = Enabled
# Run as Administrator

$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
$name = 'NoLockScreenSlideshow'
$desired = 1

# Ensure the key exists
if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

# Read current value (if any)
$current = (Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue).$name

# Apply if different
if ($current -ne $desired) {
    New-ItemProperty -Path $path -Name $name -Value $desired -PropertyType DWord -Force | Out-Null
    Write-Host "Set $name to $desired at $path"
} else {
    Write-Host "Compliant: $name already $desired"
}

# Verify
(Get-ItemProperty -Path $path -Name $name).$name
