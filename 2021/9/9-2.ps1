$data = (gc C:\aoc\2021\9\input.txt)
$matrix=@()
for ($i=0;$i -lt $data.Length;$i++) {
    $matrix+=@(,[int[]][string[]][char[]]$data[$i])
}
$rowcount=$matrix.Count
$colcount=$matrix[0].Count
$riskpoints = @()
for ($y = 0;$y -lt $rowcount;$y++) {
    for ($x = 0;$x -lt $colcount;$x++) {
        $lowercount=0
        foreach ($y1 in -1..1) {
            foreach ($x1 in -1..1) {
                if ([math]::abs($y1+$x1) -eq 1) {
                    $y2=$y+$y1
                    $x2=$x+$x1
                    if ($y2 -in 0..($rowcount-1) -and $x2 -in 0..($colcount-1)) {
                        #write-host ('in', 'pos', $x, $y, 'offset', $x1, $y1, 'comppos', $x2, $y2)
                        if ($matrix[$y][$x] -lt $matrix[$y2][$x2]) {
                            #write-host ('lowerthan', $matrix[$y][$x], $matrix[$y2][$x2])
                            $lowercount++
                        }
                    } else {
                        $lowercount++
                        #write-host ('out', 'pos', $x, $y, 'offset', $x1, $y1, 'comppos', $x2, $y2, 'lower', $lowercount)
                    }
                }
            }
        }
        if ($lowercount -eq 4) {
            #write-host ('lowest', $x, $y)
            $riskpoints += [pscustomobject]@{
                x=$x
                y=$y
                v=$matrix[$y][$x]
            }
        }
    }
}

function countandmove {
    param (
        $x,
        $y
    )
    #write-host ('enter', $x, $y, $matrix[$y][$x])
    $global:basinsize++
    $currval=$matrix[$y][$x]
    $matrix[$y][$x] = -1
    foreach ($y1 in -1..1) {
        foreach ($x1 in -1..1) {
            if ([math]::abs($y1+$x1) -eq 1) {
                $y2=$y+$y1
                $x2=$x+$x1
                if ($y2 -in 0..($rowcount-1) -and $x2 -in 0..($colcount-1)) {
                    #write-host ('in', 'pos', $x, $y, 'offset', $x1, $y1, 'comppos', $x2, $y2)
                    if ($currval -lt $matrix[$y2][$x2] -and $matrix[$y2][$x2] -ge 0 -and $matrix[$y2][$x2] -lt 9) {
                        #write-host ('uphill', 'pos', $x, $y, 'val', $currval, 'cpos', $x2, $y2, 'cval', $matrix[$y2][$x2])
                        #pause
                        countandmove $x2 $y2
                    }
                } else {
                    #write-host ('out', 'pos', $x, $y, 'offset', $x1, $y1, 'comppos', $x2, $y2, 'lower', $lowercount)
                }
            }
        }
    }
    #pause
}

$basinsizes = @()
foreach ($riskpoint in $riskpoints) {
    $global:basinsize=0
    countandmove $riskpoint.x  $riskpoint.y
    $basinsizes+=$basinsize
}
$largestbasins=$basinsizes|sort -desc|select -First 3
$largestbasins[0]*$largestbasins[1]*$largestbasins[2]