<#
.SYNOPSIS
    This PowerShell script sets the password history to 24 passwords remembered.

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-22
    Last Modified   : 2025-10-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 
#>
# WN10-AC-000020: Enforce password history = 24 passwords remembered
# Run as Administrator

$current = (net accounts | findstr /C:"Length of password history").Split(":")[1].Trim()

# Handle "None" gracefully
if ($current -eq "None") { $current = 0 } else { $current = [int]$current }

if ($current -lt 24) {
    Write-Host "Non-compliant: History is $current. Fixing to 24..."
    net accounts /uniquepw:24
} else {
    Write-Host "Compliant: History is $current (no change)."
}

net accounts | findstr /C:"Length of password history"
