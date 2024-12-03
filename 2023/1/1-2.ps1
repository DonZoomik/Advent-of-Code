$data = gc C:\aoc2023\1\input.txt

[regex]$regex = 'one|two|three|four|five|six|seven|eight|nine'
$map = @{
    one = '1'
    two = '2'
    three = '3'
    four = '4'
    five = '5'
    six = '6'
    seven = '7'
    eight = '8'
    nine = '9'
}

$map.'two'
$sum = 0
foreach ($row in $data) {
    #write-host $row
    $chararray = $row.ToCharArray()
    ##write-host ($chararray -join ',')
    for ($i=0;$i -lt $chararray.Count;$i++) {
        $isnum = $chararray[$i] -match '\d'
        $subst = $chararray[0..$i] -join ''
        #write-host $subst
        $match = ($regex.Matches($subst))[0].value
        #write-host $match
        if ($isnum) {
            [char]$firstnum = $chararray[$i]
            break
        } elseif ($match) {
            [char]$firstnum = $map.$match
            #write-host $firstnum
            break
        }
    }
    #write-host $firstnum
    for ($i = ($chararray.Count)-1;$i -ge 0;$i--) {
        $isnum = $chararray[$i] -match '\d'
        $subst = $chararray[$i..(($chararray.Count)-1)] -join ''
        #write-host $subst
        $match = ($regex.Matches($subst))[0].value
        #write-host $match
        if ($isnum) {
            [char]$lastnum = $chararray[$i]
            #write-host $lastnum
            break
        } elseif ($match ) {
            [char]$lastnum = $map.$match
            #write-host $lastnum
            break
        }
    }

    #write-host $lastnum
    [int] $calnum = $firstnum+$lastnum
    $sum = $sum + $calnum    
    #write-host ('f', $firstnum, 'l', $lastnum, 'c',$calnum,'t',$sum)
    #pause
} 
$sum