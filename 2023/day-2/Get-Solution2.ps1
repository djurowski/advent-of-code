[CmdletBinding()]
param (
    [string]$DataLocation
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

function script:Main {
    $colours = @{
        "red" = 0
        "green" = 0
        "blue" = 0
    }

    $data = Get-Content -Path $DataLocation
    $final_sum = 0
    $mult = 1

    foreach ($line in $data) {
        $split_values = $line -split "[,;:]"
        foreach ($value in $split_values[1..$split_values.Length]) {
            $singles = $value -split " "
            if ($colours[$singles[2]] -lt [int]$singles[1]) {
                $colours[$singles[2]] = [int]$singles[1]
            }
        }

        $keys = $colours.Keys | ForEach-Object { $_ }
        foreach ($col in $keys) {
            $mult *= $colours[$col]
            $colours[$col] = 0
        }

        $final_sum += $mult
        $mult = 1
    }
    write-host $final_sum
}
Main