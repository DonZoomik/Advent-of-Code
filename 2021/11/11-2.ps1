$data = (gc C:\aoc\2021\11\input.txt)
$matrix=@()
$flashescount=0
$steps = 100
for ($i=0;$i -lt $data.Length;$i++) {
    $matrix+=@(,[int[]][string[]][char[]]$data[$i])
}
$rowcount=$matrix.Count
$colcount=$matrix[0].Count
write-host 'start'
$matrix|%{$_ -join ''|write-host}
write-host ' '
$flashtest=$rowcount*$colcount

for ($j=1;$j -le 2147483647;$j++) {
    $flashesperstep=0
    #$flashes = New-Object int[][] ($matrix.Count),($matrix[0].count)
    #inc
    for ($y = 0;$y -lt $rowcount;$y++) {
        for ($x = 0;$x -lt $colcount;$x++) {
            $matrix[$y][$x]++
        }
    }

    #write-host ('endofgrow', $j)
    #$matrix|%{$_ -join ''|write-host}
    #write-host ' '

    #flash
    $flashescont=$true
    while ($flashescont) {
        #write-host 'enterwhile'
        $flashescont=$false
        for ($y = 0;$y -lt $rowcount;$y++) {
            for ($x = 0;$x -lt $colcount;$x++) {
                #write-host ('flashtest', $x, $y, $matrix[$x][$y])
                if ($matrix[$y][$x] -gt 9) {
                    #write-host ('flashmatch', $x, $y, $matrix[$y][$x])
                    $flashescont=$true
                    $flashesperstep++
                    $matrix[$y][$x] = 0
                    #write-host ('flashmatch', $x, $y, $matrix[$y][$x], $flashescount, $flashescont)
                    for ($y1=-1;$y1 -le 1;$y1++) {
                        $y2=$y+$y1
                        #write-host ('ycheck',$y,$y1,$y2)
                        if ($y2 -ge 0 -and $y2 -le $rowcount-1) {
                            for ($x1=-1;$x1 -le 1;$x1++) {
                                $x2=$x+$x1
                                #write-host ('xcheck',$x,$x1,$x2)
                                if ($x2 -ge 0 -and $x2 -le $colcount-1) {
                                    #write-host ('adjacentcheck', $y2, $x2, $matrix[$y2][$x2])
                                    #pause
                                    if ($x2 -eq $x -and $y2 -eq $y) {
                                        #write-host ('selfskip',$x, $x2, $y, $y2)
                                    }else{
                                        if ($matrix[$y2][$x2] -in 1..9) {
                                            $matrix[$y2][$x2]++
                                            #write-host ('inc',$y2, $x2, $matrix[$y2][$x2])
                                            #pause
                                        }
                                    }
                                }
                            }
                        } else {
                            #write-host ('youtofrange',$y,$y1,$y2)
                        }
                    }
                    #write-host ('flashend', $x, $y, $matrix[$x][$y], $flashescount, $flashescont)
                }
            }
        }
        #$matrix|%{$_ -join ''|write-host}
        #pause
    }
    #write-host ('endofstep', $j, $flashescount)
    #$matrix|%{$_ -join ''}
    #write-host ' '
    #pause
    if ($flashesperstep -eq $flashtest) {
        write-host ('endofstep', $j, $flashesperstep)
        pause
    } else {
        #write-host ('endofstep', $j, $flashesperstep)
    }

}
#$flashescount