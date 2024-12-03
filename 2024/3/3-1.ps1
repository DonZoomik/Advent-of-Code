#$data = gc C:\aoc\2024\3\test.txt
$data = gc "C:\aoc\2024\3\data.txt"

$sum = 0
$muls = ($data | Select-String -Pattern 'mul\(\d{1,3},\d{1,3}\)' -AllMatches).Matches.value
foreach ($mul in $muls) {
    [int[]]$digits = ($mul | select-string -pattern '\d+' -AllMatches).Matches.value
    $sum += $digits[0] * $digits[1]
}
$sum