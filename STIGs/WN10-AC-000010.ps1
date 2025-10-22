<#
.SYNOPSIS
    This PowerShell script sets the number of allowed failed login attempts to 3.

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-21
    Last Modified   : 2025-10-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

#>
# WN10-AC-000010: Account lockout threshold should be 3 or less (not 0)
# Run as Administrator

# Step 1: Check current lockout threshold
$current = (net accounts | findstr /C:"Lockout threshold").Split(":")[1].Trim()

# Step 2: Convert "Never" to 0 for comparison
if ($current -eq "Never") { $current = 0 } else { $current = [int]$current }

# Step 3: Check compliance
if ($current -eq 0 -or $current -gt 3) {
    Write-Host "Non-compliant: Current threshold is $current. Fixing..."
    net accounts /lockoutthreshold:3
} else {
    Write-Host "Compliant: Current threshold is $current (no change needed)."
}

# Step 4: Verify the change
net accounts | findstr /C:"Lockout threshold"
