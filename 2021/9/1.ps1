$data = (gc C:\aoc\2021\9\input.txt)
$riskpoints=@()
for ($y=0;$y -lt $data.Length;$y++) {
    $checkup=$checkdown=$true
    if ($y -eq 0) {
        $checkup = $false
    } elseif ($y -eq ($data.Length-1)) {
        $checkdown = $false
    }
    [int[]][string[]][char[]]$row = $data[$y]
    for ($x=0;$x -lt $row.Count;$x++) {
        $checkleft=$checkright=$true
        $uprow=$downrow=$null
        if ($x -eq 0) {
            $checkleft = $false
        } elseif ($x -eq $row.Count-1) {
            $checkright = $false
        }

        #write-host ('check','l',$checkleft,'r',$checkright,'u',$checkup,'d',$checkdown)
        $lowerleft=$true
        $lowerright=$true
        $lowerup=$true
        $lowerdown=$true
        if ($checkleft) {
            if ($row[$x] -ge $row[$x-1]) {
                $lowerleft = $false
            }
            #write-host ('left',$x, $row[$x], ($x-1), $row[$x-1], $lowerleft)
        }
       
        if ($checkright -and $lowerleft) {
            if ($row[$x] -ge $row[$x+1]) {
                $lowerright = $false
            }
            #write-host ('right',$x, $row[$x], ($x+1), $row[$x+1], $lowerright)
        }
        
        if ($checkup -and $lowerleft -and $lowerright) {
            [int[]][string[]][char[]]$uprow = $data[$y-1]
            if ($row[$x] -ge $uprow[$x]) {
                $lowerup = $false
            }
            #write-host ('up',$x, $row[$x], ($x), $uprow[$x], $lowerup)
        } else {
            #$uprow='X'
        }
        
        if ($checkdown -and $lowerleft -and $lowerright -and $lowerup) {
            [int[]][string[]][char[]]$downrow = $data[$y+1]
            if ($row[$x] -ge $downrow[$x]) {
                $lowerdown = $false
            }
            #write-host ('down',$x, $row[$x], ($x), $downrow[$x], $lowerdown)
        } else {
            #$downrow='X'
        }
        if ($lowerleft -and $lowerright -and $lowerup -and $lowerdown){
            #write-host ('lowest', $x, $y, $row[$x], $row[$x-1], $row[$x+1], $uprow[$x], $downrow[$x])
            #pause
            $riskpoints += @{
                x=$x
                y=$y
                v=$row[$x]
            }
        }
        #pause
    }
}

$riskpoints|%{[PSCustomObject]$_}|ft x,y,v
pause
$riskpoints.v|%{$_+1}|measure -sum
$riskpoints.v