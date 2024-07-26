[CmdletBinding()]
param (
    [string]$DataLocation
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

function script:Main {
    $number_table = [ordered]@{
        # I'm not sure why there are numbers like that and they are valid
        "eightwo" = 82
        "twone" = 21
        "oneight" = 18
        "one" = 1
        "two" = 2
        "three" = 3
        "four" = 4
        "five" = 5
        "six" = 6
        "seven" = 7
        "eight" = 8
        "nine" = 9
    }
    $final_sum = 0
    $data = Get-Content -Path $DataLocation

    foreach ($line in $data) {
        foreach ($h in $number_table.GetEnumerator()) {
            $line = $line.Replace($($h.Key), $($h.Value))
        }
        $numbers = $line -replace "[^\d]", ""
        $combined_number = $numbers[0] + $numbers[-1]
        $final_sum += [int]$combined_number
    }
    Write-Output $final_sum
}
Main