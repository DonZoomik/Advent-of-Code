measure-command {
#$data = gc "C:\aoc\Advent-of-Code\2024\5\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\5\data.txt"

$break = 0
$sum = 0

#rm "C:\aoc\Advent-of-Code\2024\5\datarules.txt" 2>$null
#rm "C:\aoc\Advent-of-Code\2024\5\datafails.txt" 2>$null
$rules = for ($i=0;$i -lt $data.count;$i++){
    if (!$data[$i]) {$break = $i;break}
 #   $data[$i] >> "C:\aoc\Advent-of-Code\2024\5\datarules.txt"
    ,($data[$i].split('|'))
}

:sequence for ($i=$break+1;$i -lt $data.count;$i++) {
    $numbers = $data[$i].Split(',')
    $sequencecorrect = $true
    $failingrule = $null
    :initnumber for ($j=0;$j -lt $numbers.count-1;$j++) {
        if (!$sequencecorrect){break initnumber}
        $currentnumber = $numbers[$j]
        :nextnumber for ($k=$j+1;$k -lt $numbers.count;$k++) {
            if (!$sequencecorrect){break nextnumber}
            $nextnumber = $numbers[$k]
            :rule for ($r=0;$r -lt $rules.count;$r++) {
                $rule = $rules[$r]
                if ($currentnumber -in $rule -and $nextnumber -in $rule) {
                    if ($currentnumber -eq $rule[0] -ne $nextnumber -eq $rule[1]) {
                        $sequencecorrect = $false 
                        $failingrule = $rule
                        break rule
                    }
                }
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
}
}   
$sum
