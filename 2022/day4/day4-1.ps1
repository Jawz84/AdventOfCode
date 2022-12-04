# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

$count = 0
$in | ForEach-Object {
    $pair = $_
    if ($pair -like '')
    { $count; break }
    $split = $pair.split(',')
    $first = $split[0]
    $second = $split[1]
    $startFirst = [int]$first.Split('-')[0]
    $endFirst = [int]$first.Split('-')[1]
    $startSecond = [int]$second.Split('-')[0]
    $endSecond = [int]$second.Split('-')[1]

    if (($startFirst -le $startSecond -and $endFirst -ge $endSecond) -or
        ($startSecond -le $startFirst -and $endSecond -ge $endFirst)) {
        $count++
    }
}
