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
