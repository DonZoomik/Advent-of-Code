$data = gc C:\aoc2023\1\input.txt

$sum = 0
foreach ($row in $data) {
    Write-Host $row
    $chararray = $row.ToCharArray()
    #write-host ($chararray -join ',')
    for ($i=0;$i -lt $chararray.Count;$i++) {
        write-host ($i,$chararray[$i] )
        if ($chararray[$i] -match '\d') {
            [char]$firstnum = $chararray[$i]
            break
        }
    }
    #write-host $firstnum
    for ($i = ($chararray.Count)-1;$i -ge 0;$i--) {
        if ($chararray[$i] -match '\d') {
            [char]$lastnum = $chararray[$i]
            break
        }
    }
    #write-host $lastnum
    [int] $calnum = $firstnum+$lastnum
    $sum = $sum + $calnum    
    write-host ('f', $firstnum, 'l', $lastnum, 'c',$calnum,'t',$sum)
    #pause
} 
$sum