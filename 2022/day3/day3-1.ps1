# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

$sum = 0

function getScore {
    param ( $Item) 
    $value = [int][char]$Item
    if ($value -ge 97) {
        # lowercase
        return $value - 96
    }
    return $value - (64 - 26)
}

foreach ($sack in $in) {
    if ($sack -like '') {break}

    $split = $sack.Length/2
    $first = $sack[0..($split-1)]
    $second = $sack[$split..($sack.Length-1)]
    $item = Compare-Object $first $second -IncludeEqual -ExcludeDifferent |
    Select-Object -ExpandProperty inputobject -First 1
    $score = getScore -Item $item
    [pscustomobject]@{
        first = -join $first
        second = -join $second
        item  = $item
        score = $score
    }
    $sum += $score
}
$sum