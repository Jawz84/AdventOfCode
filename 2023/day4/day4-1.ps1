# https://adventofcode.com/2023/day/4 

# example input
$in = Get-Content -Path .\2023\day4\exampleinput.txt | where {$_ -ne '' }
 
# puzzle input
$in = Get-Content -Path .\2023\day4\input.txt | where {$_ -ne '' }
$sum = 0
foreach ($line in $in) {
    $split = $line.split('|')
    $winningNumbers = $split[0].split(':'[1]).split(' ') | where {$_ -ne ''}
    $myNumbers = $split[1].split(' ')| where {$_ -ne ''}
    $wonNumbers = $myNumbers | where { $_ -in $winningNumbers}
    # $wonNumbers -join ' '
    if ($wonNumbers.Count -eq 0) {
        continue
    }
    $sum += [math]::Pow(2, $wonNumbers.Count -1)
}
$sum
