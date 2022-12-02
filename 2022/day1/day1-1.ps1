# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

$max = 0
$sum = 0
foreach ($line in $in) {
    if ($line -like '') {
        if ($sum -gt $max) {
            $max = $sum
        }
        $sum = 0
    }
    $sum += [int]$line
}
$max