$input = gc c:\aoc\2015\3\input.txt

foreach ($line in $input){
    $xsanta=0
    $ysanta=0
    $xrobot=0
    $yrobot=0
    $chararray = $line.tochararray()
    $santa=@('0,0')
    $robot=@('0,0')
    for ($i=0;$i -lt $chararray.length;$i++) {
        #$i, $chararray[$i]
        if ($i % 2 -eq 0) {
                switch ($chararray[$i]) {
                '<' {$xsanta--}
                '>' {$xsanta++}
                '^' {$ysanta++}
                'v' {$ysanta--}
            }
            $santa += "$xsanta,$ysanta"
        } else {
            switch ($chararray[$i]) {
                '<' {$xrobot--}
                '>' {$xrobot++}
                '^' {$yrobot++}
                'v' {$yrobot--}
            }
            $robot += "$xrobot,$yrobot"

        }
    }

       
    #$santa
    #$santa | select -Unique | measure
    #$robot
    #$robot | select -Unique | measure
    #$santa,$robot
    ($santa + $robot) | select -Unique | measure 
    #pause
}