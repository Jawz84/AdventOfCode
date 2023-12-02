# https://adventofcode.com/2023/day/1 

# example input
$in = Get-Content -Path .\2023\day1\exampleinput.txt

# puzzle input
$in = Get-Content -Path .\2023\day1\input.txt

# foreach line in $in, get the first digit and the last digit. The strings may contain other characters.

function findFirstNumber {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Line
    )
    # adjust for the fact that the line may start with random characters instead of a digit
    # For example: pqr3stu8vwx -> 3

    $first = ($Line -replace '^[^0-9]*')[0]
    return $first
}

function findLastNumber {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Line
    )
    $last = ($Line -replace '[^0-9]*$')[-1]
    return $last
}


$sum = 0
foreach ($code in $in | where {$_ -ne ''}) {
    $first = findFirstNumber -Line $code
    $last = findLastNumber -Line $code
    $sum += [int]"$first$last"
}

$sum