# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

$inChars = $in.ToCharArray()

$markerLenght = 14
for ($i = 0; $i -lt $inChars.Length - $markerLenght; $i++) {
    $tempHash = @{}

    for ($x = 0; $x -lt $markerLenght; $x++) {
        $tempHash.($inChars[$i + $x]) = $i + $x
    }

    if ($tempHash.Count -eq $markerLenght) {
        return $i + $markerLenght
    }
}