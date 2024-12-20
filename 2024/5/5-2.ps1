#$data = gc "C:\aoc\Advent-of-Code\2024\5\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\5\data.txt"
$goodsum = 0
$badsum = 0
$break = for ($i=0;$i -lt $data.count;$i++){
    if (!$data[$i]) {$i;break}
}

$rules = for ($i=0;$i -lt $data.count;$i++){
    if (!$data[$i]) {$break = $i;break}
    ,($data[$i].split('|'))
}

Import-Module -name  C:\aoc\Advent-of-Code\2024\5\Permutation.psm1

function testvalid {
    param(
        $sequence,
        $start = 0
    )
    $sequencecorrect = $true
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
    $numbers = $data[$i].Split(',')
    $result = testvalid -sequence $numbers
    if (!$result) {
        #write-host "G $($numbers -join ',')"
        $middlepoint = [math]::Floor($numbers.count/2)
        #write-host "M $middlepoint $($numbers[$middlepoint])"
        $goodsum += $numbers[$middlepoint]
    } else {
        $permutations = Get-Permutation $numbers
        write-host "$i $($permutations.count) $(get-date)"
        foreach ($permutation in $permutations) {
            $numbers = $permutation -split ' '
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
$goodsum
$badsum