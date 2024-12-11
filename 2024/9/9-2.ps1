#$data = gc "C:\aoc\Advent-of-Code\2024\9\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\9\data.txt"

$digits = $data.ToCharArray()|%{[System.Int32]::Parse($_)}
$bitmaplength = ($digits|measure -sum).sum
$bitmap = New-Object 'object[]' $bitmaplength

$pos=0
$numdigit=0
for ($i=0;$i -lt $digits.count;$i++) {
    switch ($i%2) {
        '0' {
            #file
            for ($j=0;$j -lt $digits[$i];$j++) {
                $bitmap[$pos] = $numdigit
                $pos++
            }
            $numdigit++
        }
        '1' {
            for ($j=0;$j -lt $digits[$i];$j++) {
                $bitmap[$pos] = '.'
                $pos++
            }
        }
    }
}
#write-host ($bitmap -join '')

$startoffree=0
function findccontinuousfree {
    param (
        $length,
        $end
    )
    
    $firsthit = $false
    for ($i=$global:startoffree;$i -lt $end;$i++) {
        $counter = 0
        if ($bitmap[$i] -eq '.') {
            if (!$firsthit) {
                $firsthit=$true
                $global:startoffree = $i
            }
            for ($j=$i;$j -lt $end;$j++) {
                if ($bitmap[$j] -eq '.') {
                    #write-host "testfree $j $($bitmap[$j])"
                    $counter++
                } else {break}
                if ($counter -ge $length){
                    #write-host "free start $i length $length"
                    write-host "f $startoffree  p$j"
                    return $i
                }
            }
        }
    }
}
function getfilesize {
    param (
        $value,
        $start
    )
    $length=0
    for ($i = $start;$i -ge 0;$i--) {
        if ($bitmap[$i] -eq $value) {
            $length++
        } else {
            return $length
        }

    }
}
function replace {
    param (
        $freestart,
        $filestart,
        $length,
        $value
    )

    for ($i = $freestart;$i -lt ($freestart+$length);$i++) {
        #write-host "setting pos $i value $value"
        $bitmap[$i] = $value
    }
    for ($i = $filestart;$i -gt ($filestart-$length);$i--) {
        #write-host "clearing pos $i"
        $bitmap[$i] = '.'
    }
}

for ($i = ($bitmap.count-1);$i -gt 0;$i--) {
    write-host "$($bitmap.count) $i"
    if ($bitmap[$i] -ne '.') {
        $filesize = getfilesize -value $bitmap[$i] -start $i
        if ($filesize) {
            #write-host "file start $i value $($bitmap[$i]) length $filesize"
            $freespacestart = findccontinuousfree -length $filesize -end $i
            if ($freespacestart) {
                replace -freestart $freespacestart -filestart $i -length $filesize -value $bitmap[$i]
            } else {
                $i=$i-$filesize+1
            }
        }
    } else {
        #write-host "free $i"
    }
    #write-host ($bitmap -join '')
    #pause
}
$numbers = for ($i = 0;$i -lt $bitmap.count;$i++) {
    if ($bitmap[$i] -ne '.') {
        #write-host "pos $i val $($bitmap[$i]) mul $($i * $bitmap[$i])"
        $i * $bitmap[$i]
    }
}
$numbers|measure -sum