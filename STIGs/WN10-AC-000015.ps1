<#
.SYNOPSIS
    This PowerShell script sets the period of time that must pass after failed logon attemps to 15 minutes.

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-22
    Last Modified   : 2025-10-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000015

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 
#>
# Reset account lockout counter after: 15 minutes

$current = (net accounts | findstr /C:"Lockout observation window").Split(":")[1].Trim()
$current = ($current -replace "minutes","" -replace "minute","").Trim()
$current = [int]$current

if ($current -lt 15) {
    Write-Host "Non-compliant: Current reset window is $current min. Fixing to 15..."
    net accounts /lockoutwindow:15
} else {
    Write-Host "Compliant: Reset window is $current min (no change)."
}

net accounts | findstr /C:"Lockout observation window"
