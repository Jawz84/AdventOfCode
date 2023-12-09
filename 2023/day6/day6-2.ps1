# https://adventofcode.com/2023/day/6 

# example input
$in = Get-Content -Path .\2023\day6\exampleinput.txt

# puzzle input
# $in = Get-Content -Path .\2023\day6\input.txt

$time = [decimal](($in[0] -split ':')[1].trim() -split ' ' -join '')
$distance = [decimal](($in[1] -split ':')[1].trim() -split ' ' -join '')


$winDistance = $distance
for ($buttonpress = 1; $buttonpress -lt $time - 1; $buttonpress++) {
    $timeLeft = $time - $buttonPress
    $speed = $buttonPress
    $distance = $timeLeft * $speed
    if ($distance -gt $winDistance) {
        "start of winning range: $buttonpress"
        $winRangeStart = $buttonpress
        break
    }
}
for ($buttonpress = $time; $buttonpress -gt $winRangeStart; $buttonpress--) {
    $timeLeft = $time - $buttonPress
    $speed = $buttonPress
    $distance = $timeLeft * $speed
    if ($distance -gt $winDistance) {
        "end of winning range: $buttonpress"
        $winRangeEnd = $buttonpress +1
        break
    }
}

$winRangeEnd-$winRangeStart

