#$data = gc "C:\aoc\Advent-of-Code\2024\4\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\4\data.txt"

$array = foreach ($row in $data) {
    ,($row.ToCharArray())
}

$test = 'XMAS|SAMX'
$colsize = $array.Count
$rowsize = $array[0].Count

$count = 0

for ($y=0;$y -lt $colsize;$y++) {
    for ($x=0;$x -lt $rowsize;$x++) {
        #horizontal
        if ($x -lt ($rowsize -3)) {
            $teststring = $array[$y][$x..($x+3)] -join ''
            if ($teststring -match $test){$count++}
        }
        #vertical
        if ($y -lt ($colsize -3)) {
            $teststring = ($array[$y][$x],$array[$y+1][$x],$array[$y+2][$x],$array[$y+3][$x]) -join ''
            if ($teststring -match $test){$count++}
        }
        #diag1
        if (($x -lt ($rowsize -3)) -and ($y -lt ($colsize -3))){
            $teststring = ($array[$y][$x],$array[$y+1][$x+1],$array[$y+2][$x+2],$array[$y+3][$x+3]) -join ''
            if ($teststring -match $test){$count++}
        }
        #diag2
        if (($x -gt 2) -and ($y -lt ($colsize -3))){
            $teststring = ($array[$y][$x],$array[$y+1][$x-1],$array[$y+2][$x-2],$array[$y+3][$x-3]) -join ''
            if ($teststring -match $test){$count++}
        }
    }
}
$count