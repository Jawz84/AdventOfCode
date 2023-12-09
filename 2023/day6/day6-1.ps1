# https://adventofcode.com/2023/day/6 

# example input
$in = Get-Content -Path .\2023\day6\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\2023\day6\input.txt

$times = $in[0] -split '\s+' | Select-Object -Skip 1 | ForEach-Object { [int]$_ }
$distances = $in[1] -split '\s+' | Select-Object -Skip 1 | ForEach-Object { [int]$_ }


$winamountProduct = 1
for ($i = 0; $i -lt $times.Length; $i++) {
    $winAmount = 0
    $time = $times[$i]
    $winDistance = $distances[$i]
    for ($buttonpress = 1; $buttonpress -lt $time - 1; $buttonpress++) {
        $timeLeft = $time - $buttonPress
        $speed = $buttonPress
        $distance = $timeLeft * $speed
        if ($distance -gt $winDistance) {
            $winAmount++
        }
    }
    $winAmountProduct *= $winAmount
}

$winamountProduct