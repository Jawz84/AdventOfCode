# https://adventofcode.com/2023/day/5 

# example input
$in = Get-Content -Path .\2023\day5\exampleinput.txt

# puzzle input
# $in = Get-Content -Path .\2023\day5\input.txt

[long[]]$seeds = $in[0].split(': ')[1].split(' ')

$linestoprocess = $in[1..$in.Length] | Where-Object { $_ -ne '' }

foreach ($line in $linestoprocess) {
    if ($line -match '([a-z-]+) map:') {
        $identifier = ($Matches.Values | Select-Object -First 1 ) -replace '-to-', '2'
        if (Get-Variable -Name $identifier -ErrorAction SilentlyContinue) {
            Remove-Variable -Name $identifier
        }
        New-Variable -Name $identifier
        continue
    }

    $destRangeStart, $sourceRangeStart, $rangeLength = $line -split ' '

    $sourceRange = [long]$sourceRangeStart..([long]$sourceRangeStart + [long]$rangeLength)
    $destRange = [long]$destRangeStart..([long]$destRangeStart + [long]$rangeLength)

    if ($null -eq (Get-Variable -Name $identifier).Value) {
        $hash = @{}
    }
    else {
        $hash = (Get-Variable -Name $identifier).Value
    }
    foreach ($i in 0..($sourceRange.Length - 1)) {
        $hash[$sourceRange[$i]] = $destRange[$i]
    }

    Set-Variable -Name $identifier -Value $hash
}

function map {
    param(
        [hashtable]$hash,
        [long]$key
    )
    if ($hash.ContainsKey($key)) {
        return $hash[$key]
    }
    write-host $key
    return $key
}

map $humidity2location (
    map $temperature2humidity (
        map $light2temperature (
            map $water2light (
                map $fertilizer2water (
                    map $soil2fertilizer (
                        map $seed2soil $seeds[0]))))))