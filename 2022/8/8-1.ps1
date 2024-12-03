#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\8\inputsample.txt"
[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\8\input.txt"

$visible = @()
for ($y=0;$y -lt $inputdata.Count;$y++){
    $trees = [int[]][string[]][char[]]$inputdata[$y]
    $highest = $trees[0]
    $visible += (0,$y -join ',')

    for ($x=1;$x -lt $trees.Count;$x++) {
        if ($trees[$x]  -gt $highest) {
            $visible += ($x,$y -join ',')
            $highest = $trees[$x]
        }
    }
    $highest = $trees[-1]
    $visible += (([int]$trees.Count - 1),$y -join ',')
    
    
    for ($x=$trees.Count -2;$x -ge 0;$x--) {
        if ($trees[$x] -gt $highest) {
            $visible += ($x,$y -join ',')
            $highest = $trees[$x]
        }
    }
}

$xlimit = $inputdata[0].ToCharArray().Count
for ($x=0;$x -lt $xlimit;$x++) {
    $trees = foreach ($line in $inputdata) {
        [int[]][string[]][char[]]$line[$x]
    }

    $highest = $trees[0]
    $visible += ($x ,0 -join ',')
    
    for ($y=1;$y -lt $trees.Count;$y++) {
        if ($trees[$y] -gt $highest) {
            $visible += ($x,$y -join ',')
            $highest = $trees[$y]
        }
    }

    $highest = $trees[-1]
    $visible += ($x,([int]$xlimit - 1) -join ',')
    for ($y=$trees.Count -2;$y -ge 0;$y--) {
        if ($trees[$y] -gt $highest) {
            $visible += ($x,$y -join ',')
            $highest = $trees[$y]
        }
    }
}

$visible|select -Unique|measure