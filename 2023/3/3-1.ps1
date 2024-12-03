$data = gc c:\aoc\3\input.txt
$matrix = @()
$specials = [ordered]@{}
for ($y=0;$y -lt $data.Count;$y++){
    $matrix += ,$data[$y].tochararray()
    for ($x=0;$x -lt $matrix[$y].Count;$x++){
        if ($matrix[$y][$x] -notmatch '[.0-9]') {
            $specials.add("$y,$x",$true)
        }
    }
}
$rowlength = $matrix[0].count
$sum = 0
for ($y=0;$y -lt $data.Count;$y++){
    write-host ('row', $y, ($matrix[$y] -join ''))
    for ($x=0;$x -lt $rowlength;$x++) {
        #write-host ('row', $y, 'pos', $x, 'val', $matrix[$y][$x])
        if ($matrix[$y][$x] -match '\d') {
            #write-host ('row', $y, 'pos', $x, 'val', $matrix[$y][$x], 'is digit')
            $begindigit = $enddigit= $x
            $digitcontinue = $true
            $x++
            while ($digitcontinue) {
                if ($matrix[$y][$x] -match '\d') {
                    #write-host ('row', $y, 'pos', ($x+$offset), 'val', $matrix[$y][$x+$offset], 'is also digit')
                    $enddigit = $x
                    $x++
                } else {
                    $digitcontinue = $false
                    if ($begindigit -eq $enddigit ) {
                        $number = $matrix[$y][$begindigit]
                    } else {
                        $number = [int]($matrix[$y][$begindigit..$enddigit] -join '')
                    }
                    #write-host ('row', $y, 'pos', ($x), 'val', $matrix[$y][$x], 'not a digit', 'startnum', $begindigit,'enddigit',$enddigit,'number',$number)
                    #pause
                }
            }
            :outer for ($yc = [math]::max($y-1,0);$yc -le [math]::min($y+1,$matrix.count-1);$yc++ ) {
                #write-host ('test row',$yc)
                for ($xc = [math]::max($begindigit-1,0);$xc -le [math]::min($enddigit+1,$rowlength-1);$xc++) {
                    #write-host ('testing', "$yc,$xc")
                    if ($specials."$yc,$xc") {
                        $sum += [System.Int32]::Parse($number)
                        write-host ('found', 'yc', $yc, 'xc',$xc,'val',$matrix[$yc][$xc],'sum',$sum)
                        #pause
                        break outer
                        break
                    }
                }
            }
        }
    }
}
$sum