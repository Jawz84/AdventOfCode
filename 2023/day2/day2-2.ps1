# https://adventofcode.com/2023/day/2 

# example input
$in = Get-Content -Path .\2023\day2\exampleinput.txt | where {$_ -ne ''}

# puzzle input
#  $in = Get-Content -Path .\2023\day2\input.txt | where {$_ -ne ''}


$games = New-Object System.Collections.Generic.List[object]

foreach ($game in $in) {
    $id, $rounds = $game -split ':'
    $id = [int]($id -replace 'Game ', '')

    $hands = New-Object System.Collections.Generic.List[object]

    foreach ($round in $rounds -split ';') {
        $hand = [pscustomobject]@{
            'red' = if ($round -match '(\d+) red') { [int]$Matches[1] }
            'green' = if ($round -match '(\d+) green') { [int]$Matches[1] }
            'blue' = if ($round -match '(\d+) blue') { [int]$Matches[1] }
        }

        $hands.Add($hand)
    }

    $gameObj = [pscustomobject]@{
        'ID' = $id
        'hands' = $hands
    }

    $games.Add($gameObj)
}

# foreach game calculate the max amount of cubes per color
$sum = 0
foreach ($game in $games) {
    $maxRed = $game.hands | Measure-Object -Property red -Maximum | Select-Object -ExpandProperty Maximum
    $maxGreen = $game.hands | Measure-Object -Property green -Maximum | Select-Object -ExpandProperty Maximum
    $maxBlue = $game.hands | Measure-Object -Property blue -Maximum | Select-Object -ExpandProperty Maximum
    $power = $maxRed * $maxGreen * $maxBlue
    $sum += $power
}

$sum