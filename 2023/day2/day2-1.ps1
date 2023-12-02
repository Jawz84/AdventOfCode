# https://adventofcode.com/2023/day/2 

# example input
$in = Get-Content -Path .\2023\day2\exampleinput.txt | where {$_ -ne ''}

# puzzle input
 $in = Get-Content -Path .\2023\day2\input.txt | where {$_ -ne ''}


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

# Check which games are possible given 12 red cubes, 13 green cubes, and 14 blue cubes

$maxRed = 12
$maxGreen = 13
$maxBlue = 14

$possibleGames = New-Object System.Collections.Generic.List[object]

foreach ($game in $games) {
    $possible = $true

    foreach ($hand in $game.hands) {
        if ($hand.red -gt $maxRed -or $hand.green -gt $maxGreen -or $hand.blue -gt $maxBlue) {
            $possible = $false
            break
        }
    }

    if ($possible) {
        $possibleGames.Add($game)
    }
}

$possibleGames | Measure-Object -Sum ID | Select-Object -ExpandProperty Sum
