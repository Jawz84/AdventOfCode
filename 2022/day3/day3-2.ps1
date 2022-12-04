# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt
$in = $in | Where-Object {$_ -notlike ''}

$sum = 0

function getScore {
    param ( $Item)
    try {
        $value = [int][char]$Item
    }
    catch {
        $value = [int][char]($Item | Sort-Object -Unique)
    }
    if ($value -ge 97) {
        # lowercase
        return $value - 96
    }
    return $value - (64 - 26)
}

for ($i = 0; $i -le $in.Length-2; $i = $i + 3) {
    $first = $in[$i]
    $second = $in[$i+1]
    $third = $in[$i+2]

    $item = (Compare-Object (Compare-Object ([char[]]$first) ([char[]]$second) -IncludeEqual -ExcludeDifferent).inputobject ([char[]]$third) -IncludeEqual -ExcludeDifferent).inputobject

    $score = getScore -Item $item

    [pscustomobject]@{
        first = $first
        second = $second
        third = $third
        item  = $item
        score = $score
    }
    $sum += $score
}
$sum