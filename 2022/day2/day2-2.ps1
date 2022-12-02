# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

function getScore ($Them, $Us) {
    switch ($Us) {
        'lose' {
            switch ($Them) {
                1 { $score = 3 + 0 }
                2 { $score = 1 + 0 }
                3 { $score = 2 + 0 }
            }
        }
        'draw' {
            switch ($Them) {
                1 { $score = 1 + 3 }
                2 { $score = 2 + 3 }
                3 { $score = 3 + 3 }
            }
        }
        'win' {
            switch ($Them) {
                1 { $score = 2 + 6 }
                2 { $score = 3 + 6 }
                3 { $score = 1 + 6 }
            }
        }
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
        'X' { $us = 'lose' }
        'Y' { $us = 'draw' }
        'Z' { $us = 'win' }
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

