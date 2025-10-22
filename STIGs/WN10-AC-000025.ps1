<#
.SYNOPSIS
    This PowerShell script sets the password age to 60 days or less.

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-22
    Last Modified   : 2025-10-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000025

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 
#>
# Maximum password age: 60 days or less (0/Unlimited is NOT allowed)

$line = (net accounts | findstr /C:"Maximum password age").ToString()
$val  = $line.Split(":")[1].Trim()

# Handle "Unlimited"
if ($val -match "Unlimited") { $current = 0 } else { $current = [int]$val }

if ($current -eq 0 -or $current -gt 60) {
    Write-Host "Non-compliant: Max age is $current. Fixing to 60..."
    net accounts /maxpwage:60
} else {
    Write-Host "Compliant: Max age is $current (no change)."
}

net accounts | findstr /C:"Maximum password age"
