[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$DataLocation
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0

function script:Main {
    $numbersPattern = "\d+"
    $symbolsPattern = "[^.\d]"

    $data = Get-Content -Path $DataLocation
    $final_sum = 0

    for ($i = 0; $i -lt $data.Count; $i++) {
        $topLine = if ($i -gt 0) { $data[$i - 1] } else { "" }
        $midLine = $data[$i]
        $botLine = if ($i -lt $data.Count - 1) { $data[$i + 1] } else { "" }

        $numbers = [regex]::Matches($midLine, $numbersPattern)

        $topLineSymbolsIndex = [regex]::Matches($topLine, $symbolsPattern) | ForEach-Object { $_.Index }
        $botLineSymbolsIndex = [regex]::Matches($botLine, $symbolsPattern) | ForEach-Object { $_.Index }

        foreach ($number in $numbers) {
            $startIndex = $number.Index
            $endIndex = $number.Index + $number.Length - 1

            $adjacentIndices = ($startIndex - 1)..($endIndex + 1)

            if (($midLine[$startIndex - 1] -match $symbolsPattern) -or 
                ($midLine[$endIndex + 1] -match $symbolsPattern) -or
                ($topLineSymbolsIndex | Where-Object { $adjacentIndices -contains $_ }) -or
                ($botLineSymbolsIndex | Where-Object { $adjacentIndices -contains $_ })) {
                $final_sum += [int]$number.Value
            }
        }
    }

    Write-Host $final_sum
}
Main