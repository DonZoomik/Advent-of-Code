$data = gc c:\aoc\2\sample.txt

$limit= @{
    red = 12
    green = 13
    blue = 14
}

$sum = 0
foreach ($row in $data){
    write-host $row
    $tokens1 = $row -split ': '
    $gameid = ($tokens1[0] -split ' ')[1]
    #write-host ('gameid', $gameid)
    $tokens2 = $tokens1[1] -split '; '
    $possible = $true
    foreach ($subgame in $tokens2) {
        #write-host ('subgame', $subgame)
        if ($possible) {
            $colors = $subgame -split ', '
            foreach ($color in $colors) {
                #write-host ('color',$color)
                if ($possible) {
                    $ctokens = $color -split ' '
                    #write-host ('ct1',$ctokens[0],'ct2',$ctokens[1],$limit.($ctokens[1]))
                    if ([int]$ctokens[0] -gt $limit.($ctokens[1])) {
                        #write-host impossible
                        $possible = $false
                        break
                    }
                }
            }
        }
    }
    if ($possible) {
        #write-host possible
        $sum += $gameid
    }
    #pause
}
$sum