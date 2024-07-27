[CmdletBinding()]
param (
    [string]$DataLocation
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

function script:Main{
    $max_colours = @{
        "red" = 12
        "green" = 13
        "blue" = 14
    }

    $data = Get-Content -Path $DataLocation
    $final_sum = 0

    foreach ($line in $data) {
        $split_values = $line -split "[,;:]"
        foreach ($value in $split_values[1..$split_values.Length]) {
            $singles = $value -split " "
            $break_state = $false

            # this is so bad
            if ($max_colours[$singles[2]] -lt [int]$singles[1]) {
                $break_state = $true
                break
            }
        }
        if (!$break_state) {
            $no_game = $split_values[0] -replace "[^\d]", ""
            $final_sum += [int]$no_game
        }
    }
    write-host $final_sum
}
Main