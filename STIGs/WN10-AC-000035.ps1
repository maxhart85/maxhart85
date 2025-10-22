<#
.SYNOPSIS
    This PowerShell script sets the minimum password length to 14.

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-22
    Last Modified   : 2025-10-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 
#>
# WN10-AC-000035: Minimum password length = 14 characters
# Run as Administrator

# Step 1: Get current setting
$current = (net accounts | findstr /C:"Minimum password length").Split(":")[1].Trim()
$current = [int]$current

# Step 2: Check compliance
if ($current -lt 14) {
    Write-Host "Non-compliant: Current minimum password length is $current. Fixing..."
    net accounts /minpwlen:14
} else {
    Write-Host "Compliant: Minimum password length is $current (no change needed)."
}

# Step 3: Verify
net accounts | findstr /C:"Minimum password length"
