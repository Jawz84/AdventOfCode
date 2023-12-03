# https://adventofcode.com/2023/day/3 

# example input
$in = Get-Content -Path .\2023\day3\exampleinput.txt | Where-Object { $_ -ne '' }
# $in = Get-Content -Path .\2023\day3\exampleinput2.txt | Where-Object { $_ -ne '' }

# puzzle input
$in = Get-Content -Path .\2023\day3\input.txt | where { $_ -ne '' }

$sum = 0

for ($i = 0; $i -lt $in.Length; $i++) {
    # find al axels
    $axels = [regex]::Matches($in[$i], '\*') |
    Select-Object @{n = 'pos'; e = { $_.Index } }, @{n = 'line'; e = { $i } }

    # per axel, find all numbers surrounding it
    foreach ($axel in $axels) {
        $numbersAround =@(
        [regex]::Matches($in[$axel.line-1], '\d+') 
         | Select-Object @{n = 'pos'; e = { $_.Index } }, @{n = 'len'; e = { $_.Length } }, Value
        [regex]::Matches($in[$axel.line+1], '\d+')
            | Select-Object @{n = 'pos'; e = { $_.Index } }, @{n = 'len'; e = { $_.Length } }, Value
        [regex]::Matches($in[$axel.line], '\d+')
            | Select-Object @{n = 'pos'; e = { $_.Index } }, @{n = 'len'; e = { $_.Length } }, Value
        )
        
        #only keep the numbers that are adjacent to the axel
        $adjacentNumbers = $numbersAround | Where-Object { $axel.pos -in (($_.pos-1)..($_.pos + $_.len)) }

        # if there are two adjacent numbers, multiply them and add to sum
        if ($adjacentNumbers.Count -eq 2) {
            $sum += [int]$adjacentNumbers[0].Value * [int]$adjacentNumbers[1].Value
        }
    }

}

$sum


