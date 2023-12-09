# https://adventofcode.com/2023/day/8 

# example input
$in = Get-Content -Path .\2023\day8\exampleinput3.txt | Where-Object { $_ -ne '' }

# puzzle input
$in = Get-Content -Path .\2023\day8\input.txt | Where-Object { $_ -ne '' }

$route = $in[0].ToCharArray()
# the route is circular, so we can just repeat it until we reach the target node

# we will be needing a data structure for binary tree
class Node {
    [string]$label
    [string]$L
    [string]$R
}

'____________________________'
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

# traverse the tree, following the route from the starting nodes ending in 'A'
# and count the steps needed to reach the target nodes that end in 'Z'

$startingNodes = $nodes[$($nodes.keys | Where-Object { $_ -like '*A' })]

$steps = @()
foreach ($current in $startingNodes) {
    $current.label

    $dist = 0
    for ($i = 0; ; $i++) {
        if ($i -eq $route.Length) {
            $i = 0
        }
        $direction = $route[$i]
        $current = $nodes[$current.$direction]
        # $current.label
        $dist++
        if ($current.label -like '*Z') {
            break
        }
    }

    $dist
    $steps += $dist
}

# we need to calculate the least common multiple of the steps

# I went to wolframalpha.com and entered the following:
# The LCM of <the numbers in $steps, separated by commas>
