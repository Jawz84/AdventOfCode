# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

function getScore ($Them, $Us) {
    $score = $Us
    if ($Them -eq 1 -and $Us -eq 3) { $Them = 4 } # make rock win from scissors
    if ($Them -eq 3 -and $us -eq 1) { $Us = 4 }
    if ($Them -gt $Us) {
        $score += 0
    }
    elseif ($Them -eq $Us) {
        $score += 3
    }
    elseif ($Them -lt $Us) {
        $score += 6
    }
    return $score
}



$in | ForEach-Object {
    $t = $_.Split(' ')

    switch ($t[0]) {
        'A' { $them = 1 }
        'B' { $them = 2 }
        'C' { $them = 3 }
        default { $them = $null }
    }
    switch ($t[1]) {
        'X' { $us = 1 }
        'Y' { $us = 2 }
        'Z' { $us = 3 }
        default { $us = $null }
    }

    if ($null -ne $them) {
        [pscustomobject]@{
            Them  = $them
            Us    = $us
            Score = getScore -Them $them -Us $us
        }
    }
} -OutVariable scores

$Scores.score | Measure-Object -Sum | Select-Object -ExpandProperty Sum

