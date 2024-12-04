#$data = gc "C:\aoc\Advent-of-Code\2024\4\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\4\data.txt"

$array = foreach ($row in $data) {
    ,($row.ToCharArray())
}

$test = 'MAS|SAM'
$colsize = $array.Count
$rowsize = $array[0].Count

$count = 0

for ($y=1;$y -lt ($colsize-1);$y++) {
    for ($x=1;$x -lt ($rowsize-1);$x++) {
        if (
            (($array[$y-1][$x-1],$array[$y][$x],$array[$y+1][$x+1]) -join '') -match $test -and 
            (($array[$y-1][$x+1],$array[$y][$x],$array[$y+1][$x-1]) -join '') -match $test

        ) {
            #write-host "$y $x"
            $count++
        }
    }
}
$count