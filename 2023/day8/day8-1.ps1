# https://adventofcode.com/2023/day/8 

# example input
$in = Get-Content -Path .\2023\day8\exampleinput2.txt | where { $_ -ne '' }

# puzzle input
$in = Get-Content -Path .\2023\day8\input.txt | where { $_ -ne '' }

$route = $in[0].ToCharArray()
# the route is circular, so we can just repeat it until we reach the target node

# we will be needing a data structure for binary tree
class Node {
    [string]$label
    [string]$L
    [string]$R
}

"____________________________"
# create a hashtable to store the nodes
$nodes = @{}
foreach ($line in $in[1..$in.Length]) {
    $parts = $line -split ' '
    $label = $parts[0]
    $left = $parts[2].trim('(,')
    $right = $parts[3].trim(')')
    $nodes[$label] = [Node]::new()
    $nodes[$label].label = $label
    $nodes[$label].L = $left
    $nodes[$label].R = $right
}

# traverse the tree, following the route from the root
# and count the steps needed to reach the target node of 'ZZZ'

$steps = 0
$current = $nodes['AAA']
for ($i = 0; ; $i++) {
    if ($i -eq $route.Length) {
        $i = 0
    }
    $direction = $route[$i]
    $current = $nodes[$current.$direction]
    # $current.label
    $steps++
    if ($current.label -eq 'ZZZ') {
        break
    }
}

$steps