<#
.SYNOPSIS
    This PowerShell script sets the minimum password age to 1 day.

.NOTES
    Author          : Graham Hart
    LinkedIn        : linkedin.com/in/graham-hart-5b0123162/
    GitHub          : github.com/maxhart85
    Date Created    : 2025-10-22
    Last Modified   : 2025-10-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 
#>
# Minimum password age: at least 1 day

$current = (net accounts | findstr /C:"Minimum password age").Split(":")[1].Trim()
$current = [int]$current

if ($current -lt 1) {
    Write-Host "Non-compliant: Min age is $current. Fixing to 1..."
    net accounts /minpwage:1
} else {
    Write-Host "Compliant: Min age is $current (no change)."
}

net accounts | findstr /C:"Minimum password age"
