measure-command {
#$data = gc "C:\aoc\Advent-of-Code\2024\5\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\5\data.txt"
$sum = 0
$break = for ($i=0;$i -lt $data.count;$i++){
    if (!$data[$i]) {$i;break}
}

$rules = for ($i=0;$i -lt $data.count;$i++){
    if (!$data[$i]) {$break = $i;break}
    ,($data[$i].split('|'))
}

for ($i=$break+1;$i -lt $data.count;$i++) {
    $numbers = $data[$i].Split(',')
    $sequencecorrect = $true
    :initnumber for ($j=0;$j -lt $numbers.count;$j++) {
        for ($r=0;$r -lt $break-1;$r++) {
            if ($numbers[$j] -eq $rules[$r][0] -and $rules[$r][1] -notin $numbers[($j)..($numbers.Count-1)] -and $rules[$r][1] -in $numbers) { 
                #write-host MISS  
                #pause
                $sequencecorrect = $false 
                break initnumber
            }
            
        }
    }
    if ($sequencecorrect) {
        #write-host "G $($numbers -join ',')"
        $middlepoint = [math]::Floor($numbers.count/2)
        #write-host "M $middlepoint $($numbers[$middlepoint])"
        $sum += $numbers[$middlepoint]
    } else {
        #write-host "F $failingrule $($numbers -join ',')"
    #    $($numbers -join ',') >> "C:\aoc\Advent-of-Code\2024\5\datafails.txt"
    }
    #pause
}
}   
$sum