[CmdletBinding()]
param (
    [string]$DataLocation
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

function script:Main {
    $final_sum = 0
    $data = Get-Content -Path $DataLocation
    foreach ($line in $data) {
        $numbers = $line -replace "[^\d]", ""
        $combined_number = $numbers[0] + $numbers[-1]
        $final_sum += [int]$combined_number
    }
    Write-Output $final_sum
}
Main