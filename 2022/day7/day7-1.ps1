# example input
$in = Get-Content -Path $PSScriptRoot\exampleinput.txt

# puzzle input
# $in = Get-Content -Path $PSScriptRoot\input.txt

$dirSizes = @{}
$cwd = [System.Collections.Stack]::new()

$in | ForEach-Object {
    if ($_.StartsWith('$ cd')) {
        if ($_ -eq '$ cd ..') {
            $cwd.Pop() | Out-Null
        }
        else {
            $cwd.Push($_.Replace( '$ cd ', ''))
        }
    }
    if ($_ -match "(?'size'^\d+)") {
        $path = $cwd -join '_'
        foreach ($folder in $cwd) {
            $dirSizes.$path += [decimal]$matches.size
            $path = $path.Replace("$($folder)_", '')
        }
    }
}

$dirSizes.Values |
    Where-Object { $_ -le 100000 } |
    Measure-Object -Sum |
    Select-Object -ExpandProperty Sum

# too high
