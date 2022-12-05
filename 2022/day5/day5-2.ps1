# https://adventofcode.com/2022/day/5 

# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
$in = Get-Content -Path $PSScriptRoot\input.txt

# read field
[string[]] $field = @()
foreach ($stackLayer in $in) {
    if ($stackLayer.StartsWith(' 1')) {
        break
    }
    $field += $stackLayer
}

$numStacks = [math]::Ceiling($stackLayer.Length / 4)
$highestStack = $field.Length

# initialize stacks
$stacks = [System.Collections.Stack[]]::new($numStacks)
for ($i=0; $i -lt $numStacks; $i++) {
    $stacks[$i] = [System.Collections.Stack]::new()
}

# fill stacks
for ($y = $highestStack - 1; $y -ge 0; $y--) {
    $i = 0
    for ($x = 1; $x -lt $stackLayer.Length; $x = $x + 4) {
        if ($field[$y][$x] -notlike ' ') {
            $stacks[$i].Push($field[$y][$x])
        }
        $i++
    }
}


# read instructions

foreach ($move in $in | Select-Object -Skip ($highestStack+2)) {
    if ($move -like '') { break}

    $move -match "move (?'amount'\d+) from (?'from'\d) to (?'to'\d)" | Out-Null
    $tempStack = [System.Collections.Stack]::new()
    for ($x=1; $x -le $Matches.amount; $x++) {
        $tempStack.Push($stacks[[int]$Matches.from-1].Pop())
    }
    for ($x=1; $x -le $Matches.amount; $x++) {
        $stacks[[int]$Matches.to-1].Push($tempStack.Pop())
    }
    # $stacks | foreach { $_ ; "--"}
}

-join $stacks.foreach{$_.Pop()}
