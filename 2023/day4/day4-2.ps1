# https://adventofcode.com/2023/day/4 

# example input
$in = Get-Content -Path .\2023\day4\exampleinput.txt | Where-Object { $_ -ne '' }
 
# puzzle input
# $in = Get-Content -Path .\2023\day4\input.txt | where {$_ -ne '' }

$i = 0

$cards = @{}
$in | ForEach-Object {
    $i++
    $line = $_
    $split = $line.split('|')
    $winningNumbers = $split[0].split(':'[1]).split(' ') | Where-Object { $_ -ne '' }
    $myNumbers = $split[1].split(' ')| Where-Object { $_ -ne '' }
    $wonNumbers = $myNumbers | Where-Object { $_ -in $winningNumbers }
    $cards[$i] = [pscustomobject]@{
        cardCount = 1
        wonCount   = $wonNumbers.Count
    }
}

# walk trough the card deck and for each card that has won, duplicate the wonCount amount of cards with that have a higher cardNumber

$cards