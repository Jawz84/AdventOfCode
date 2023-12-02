# https://adventofcode.com/2023/day/1 

# example input
$in = Get-Content -Path .\2023\day1\exampleinput2.txt | where {$_ -ne ''}

# puzzle input
$in = Get-Content -Path .\2023\day1\input.txt | where {$_ -ne ''}

# foreach line in $in, get the first digit and the last digit. The strings may contain other characters.
$mapper = @{
    'one' = 1
    'two' = 2
    'three' = 3
    'four' = 4
    'five' = 5
    'six' = 6
    'seven' = 7
    'eight' = 8
    'nine' = 9
    '1' = 1
    '2' = 2
    '3' = 3
    '4' = 4
    '5' = 5
    '6' = 6
    '7' = 7
    '8' = 8
    '9' = 9
}
$nums = '1', 'one', '2', 'two', '3', 'three', '4', 'four', '5', 'five', '6', 'six', '7', 'seven', '8', 'eight', '9', 'nine'

$sum = 0
foreach ($code in $in) {
    $numIndexes = @()
    foreach ($num in $nums) {
        $numIndexes += [regex]::Matches($code, $num)
    }

    $sortedItems = $numIndexes | Sort-Object -property Index 
    $first = $sortedItems | Select-Object -first 1 | Select-Object -ExpandProperty Value
    $last = $sortedItems | Select-Object -last 1 | Select-Object -ExpandProperty Value

    $sum += [int]"$($mapper[$first])$($mapper[$last])"
}

$sum