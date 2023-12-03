# https://adventofcode.com/2023/day/3 

# example input
$in = Get-Content -Path .\2023\day3\exampleinput.txt | Where-Object { $_ -ne '' }
# $in = Get-Content -Path .\2023\day3\exampleinput2.txt | Where-Object { $_ -ne '' }

# puzzle input
$in = Get-Content -Path .\2023\day3\input.txt | where { $_ -ne '' }

$sum = 0

$symbols = '\*|\+|=|%|-|#|@|/|&|\$'

for ($i = 0; $i -lt $in.Length; $i++) {
    # read the line and find all numbers in it, with their positions and lengths
    $numbers = [regex]::Matches($in[$i], '\d+') 
    | Select-Object @{n = 'pos'; e = { $_.Index } }, @{n = 'len'; e = { $_.Length } }, Value
    
    # for each number in numbers, check if it is adjacent to any symbol in the same line, or the line above or below
    # write-host -nonewline $in[$i]
    foreach ($number in $numbers) {
        $one = 1
        if ($number.pos -eq 0) {
            $one = 0
        }
        $two = 2
        if ($number.pos + $number.len -eq $in[$i].Length) {
            $two = 1
        }
        $before = $in[$i][$number.pos - $one]
        $after = $in[$i][$number.pos + $number.len + $two - 2]

        if ($i -ne 0) {
            $above = $in[$i - 1].Substring($number.pos - $one, $number.len + $two)
        }
        else {
            $above = '.'
        }
        if ($i -ne $in.Length - 1) {
            $below = $in[$i + 1].Substring($number.pos - $one, $number.len + $two)
        }
        else {
            $below = '.'
        }

        if ($before+$after+$below+$above -match $symbols) {
            $sum += $number.Value
            # Write-host -NoNewline " + $($number.Value)"
        }
    }
    # write-host 
}
$sum


