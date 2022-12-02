# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

$first = 0
$second = 0
$third = 0
$sum = 0
foreach ($line in $in) {
    if ($line -like '') {
        if ($sum -gt $first) {
            $third = $second
            $second = $first
            $first = $sum
        }
        elseif ($sum -gt $second) {
            $third = $second
            $second = $sum
        }
        elseif ($sum -gt $third) {
            $third = $sum
        }
        $sum = 0
    }
    $sum += [int]$line
}
$first + $second + $third