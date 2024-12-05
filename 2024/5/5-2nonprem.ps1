Measure-Command {
#$data = gc "C:\aoc\Advent-of-Code\2024\5\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\5\data.txt"
$goodsum = 0
$badsum = 0
$rules = for ($i=0;$i -lt $data.count;$i++){
    if (!$data[$i]) {$break = $i;break}
    ,($data[$i].split('|'))
}

function testvalid {
    param(
        $sequence,
        $start = 0
    )
    :initnumber for ($j=$start;$j -lt $numbers.count;$j++) {
        for ($r=0;$r -lt $break-1;$r++) {
            if ($numbers[$j] -eq $rules[$r][0] -and $rules[$r][1] -notin $numbers[($j)..($numbers.Count-1)] -and $rules[$r][1] -in $numbers) { 
                #write-host MISS  
                #pause
                return @{
                    pos=$j
                    rul=$r
                }
                break initnumber
            }
        }
    }
    return $null
}

for ($i=$break+1;$i -lt $data.count;$i++) {
    write-host $i
    $numbers = $data[$i].Split(',')
    $result = testvalid -sequence $numbers
    if (!$result) {
        #write-host "G $($numbers -join ',')"
        $middlepoint = [math]::Floor($numbers.count/2)
        #write-host "M $middlepoint $($numbers[$middlepoint])"
        $goodsum += $numbers[$middlepoint]
    } else {
        while ($true) {
            $n1 = $rules[$result.rul][0]
            $n2 = $rules[$result.rul][1]
            $posn1 = $result.pos
            $posn2 = $numbers.IndexOf($n2)
            $numbers[$posn1] = $n2
            $numbers[$posn2] = $n1
            $result = testvalid -sequence $numbers
            if (!$result) {
                $middlepoint = [math]::Floor($numbers.count/2)
                $badsum += $numbers[$middlepoint]
                break
            } 
        }
        #write-host "F $failingrule $($numbers -join ',')"
    #    $($numbers -join ',') >> "C:\aoc\Advent-of-Code\2024\5\datafails.txt"
    }
    #pause
}
}
$goodsum
$badsum