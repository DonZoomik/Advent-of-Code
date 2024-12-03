#$data = gc C:\aoc\2024\3\test2.txt
$data = gc "C:\aoc\2024\3\data.txt"

$sum = 0
$muls = ($data | Select-String -Pattern 'mul\(\d{1,3},\d{1,3}\)|do\(\)|don\''t\(\)' -AllMatches).Matches.value
$do = $true
foreach ($mul in $muls) {
    switch ($mul.split('(')[0]) {
        'do' {
            $do = $true
        }
        'don''t' {
            $do = $false
        }
        'mul' {
            if ($do) {
                [int[]]$digits = ($mul | select-string -pattern '\d+' -AllMatches).Matches.value
                $sum += $digits[0] * $digits[1]
            }
        }
    } 
}
$sum

