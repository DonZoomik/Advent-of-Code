
$data = gc "C:\aoc\Advent-of-Code\2024\5\testfails.txt"
$rules = gc "C:\aoc\Advent-of-Code\2024\5\testrules.txt" | % {
    ,($_.split('|'))
}
#>
<#
$data = gc "C:\aoc\Advent-of-Code\2024\5\datafails.txt"
$rules = gc "C:\aoc\Advent-of-Code\2024\5\datarules.txt" | % {
    ,($_.split('|'))
}
#>
function test {
    param(
        $sequence,
        $rules,
        $start=0
    )
    $numbers = $sequence.Split(',')
    :initnumber for ($j=$start;$j -lt $numbers.count-1;$j++) {
        $currentnumber = $numbers[$j]
        :nextnumber for ($k=$j+1;$k -lt $numbers.count;$k++) {
            $nextnumber = $numbers[$k]
            :rule for ($r=0;$r -lt $rules.count;$r++) {
                $rule = $rules[$r]
                if ($currentnumber -in $rule -and $nextnumber -in $rule) {
                    if ($currentnumber -eq $rule[0] -ne $nextnumber -eq $rule[1]) {
                        write-host "$($sequence -join ',') $currentnumber $nextnumber $($rule[0])|$($rule[1])"
                        break initnumber
                    }
                }
            }
        }
    }
}

foreach ($row in $data) {
    test -sequence $row -rules $rules
}
