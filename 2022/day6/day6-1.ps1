# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

$inChars = $in.ToCharArray()

for ($i = 0; $i -lt $inChars.Length - 4; $i++) {
    $tempHash = @{}
    $tempHash.($inChars[$i]) = $i
    $tempHash.($inChars[$i + 1]) = $i + 1
    $tempHash.($inChars[$i + 2]) = $i + 2
    $tempHash.($inChars[$i + 3]) = $i + 3
    if ($tempHash.Count -eq 4) {
        return $i + 4
    }
}