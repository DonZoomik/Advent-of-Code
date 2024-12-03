$input = gc c:\aoc\2015\3\input.txt

foreach ($line in $input){
    [string[]]$positions = $(
        "0,0"
        $x=0
        $y=0
        foreach ($char in $line.tochararray()){
            switch ($char) {
                '<' {$x--}
                '>' {$x++}
                '^' {$y++}
                'v' {$y--}
            }
            "$x,$y"
        }
    )
    $positions
    $positions | select -Unique | measure
}