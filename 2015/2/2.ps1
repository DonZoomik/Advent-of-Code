$input = gc c:\aoc\2015\2\input.txt

$total = 0

foreach ($box in $input) {
    [int[]]$sides = $box -split 'x'
    $face1 = $sides[0] * $sides[1]
    $face2 = $sides[1] * $sides[2]
    $face3 = $sides[2] * $sides[0]

    $shortestsides = $sides | sort -desc | select -last 2
    $totalribbon = $shortestsides[0] * 2 + $shortestsides[1] * 2 + $sides[0] * $sides[1] * $sides[2]
    $totalribbon
    $total=$total + $totalribbon
}

$total