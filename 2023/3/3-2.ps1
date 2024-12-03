$data = gc c:\aoc\3\input.txt
$matrix = @()
$specials = @{}
for ($y=0;$y -lt $data.Count;$y++){
    $matrix += ,$data[$y].tochararray()
    for ($x=0;$x -lt $matrix[$y].Count;$x++){
        if ($matrix[$y][$x] -match '\*') {
            $specials.add("$y,$x",@())
        }
    }
}
$rowlength = $matrix[0].count
for ($y=0;$y -lt $data.Count;$y++){
    write-host ('row', $y, ($matrix[$y] -join ''))
    for ($x=0;$x -lt $rowlength;$x++) {
        #write-host ('row', $y, 'pos', $x, 'val', $matrix[$y][$x])
        if ($matrix[$y][$x] -match '\d') {
            #write-host ('row', $y, 'pos', $x, 'val', $matrix[$y][$x], 'is digit')
            $begindigit = $enddigit = $x
            $digitcontinue = $true
            $x++
            while ($digitcontinue) {
                if ($matrix[$y][$x] -match '\d') {
                    #write-host ('row', $y, 'pos', ($x+$offset), 'val', $matrix[$y][$x+$offset], 'is also digit')
                    $enddigit = $x
                    $x++
                } else {
                    $digitcontinue = $false
                    $number = [int]($matrix[$y][$begindigit..$enddigit] -join '')
                    #write-host ('row', $y, 'pos', ($x), 'val', $matrix[$y][$x], 'not a digit', 'startnum', $begindigit,'enddigit',$enddigit,'number',$number)
                    #pause
                }
            }
            :outer for ($yc = [math]::max($y-1,0);$yc -le [math]::min($y+1,$matrix.count-1);$yc++ ) {
                #write-host ('test row',$yc)
                for ($xc = [math]::max($begindigit-1,0);$xc -le [math]::min($enddigit+1,$rowlength-1);$xc++) {
                    #write-host ('testing', "$yc,$xc")
                    if ($specials.containskey("$yc,$xc")) {
                        $specials."$yc,$xc" += ,[System.Int32]::Parse($number)
                        #write-host ('found', 'yc', $yc, 'xc',$xc,'val',$matrix[$yc][$xc],'sum',$sum)
                        #pause
                        break outer
                        break
                    }
                }
            }
        }
    }
}
$sum=0
$specials.GetEnumerator()|%{
    $cur= $_
    if ($cur.Value.count -eq 2) {
        $cursum = $cur.value[0]*$cur.value[1]
        $sum += $cursum
    }
}
$sum