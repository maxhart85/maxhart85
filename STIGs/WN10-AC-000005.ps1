<#
.SYNOPSIS
    This PowerShell script checks the current lockout duration, and if needed, sets the account lockout duration to 15 minutes.

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-21
    Last Modified   : 2025-10-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 
#>
# WN10-AC-000005: Account lockout duration must be 15 minutes or greater, OR 0 (admin unlock required)
# Run as Administrator

# Step 1: Get the current lockout duration
$current = (net accounts | findstr /C:"Lockout duration").Split(":")[1].Trim()
$current = $current -replace "minutes","" -replace "minute",""
$current = $current.Trim()

# Step 2: Convert to integer (handle "Forever" if it appears)
if ($current -eq "Forever") { $current = 0 } else { $current = [int]$current }

# Step 3: Check compliance
if ($current -eq 0 -or $current -ge 15) {
    Write-Host "Compliant: Current lockout duration is $current minute(s). No change needed."
} else {
    Write-Host "Non-compliant: Current lockout duration is $current minute(s). Fixing..."
    net accounts /lockoutduration:15
}

# Step 4: Verify the result
net accounts | findstr /C:"Lockout duration"
