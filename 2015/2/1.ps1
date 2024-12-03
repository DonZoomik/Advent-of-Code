$input = gc c:\aoc\2015\2\input.txt

$total = 0

foreach ($box in $input) {
    [int[]]$sides = $box -split 'x'
    $face1 = $sides[0] * $sides[1]
    $face2 = $sides[1] * $sides[2]
    $face3 = $sides[2] * $sides[0]

    $min = $face1,$face2,$face3 | sort -desc | select -last 1

    $boxtotal = $min + 2*$face1 + 2*$face2 + 2*$face3
    $boxtotal
    $total=$total + $boxtotal
}

$total