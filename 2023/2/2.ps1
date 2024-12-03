$data = gc c:\aoc\2\input.txt

$sum = 0
foreach ($row in $data){
    $min = @{
        red = 0
        green = 0
        blue = 0
    }
    $tokens1 = $row -split ': '
    $gameid = ($tokens1[0] -split ' ')[1]
    #write-host ('gameid', $gameid)
    $tokens2 = $tokens1[1] -split '; '
    #$possible = $true
    foreach ($subgame in $tokens2) {
        #write-host ('subgame', $subgame)
        $colors = $subgame -split ', '
        foreach ($color in $colors) {
            #write-host ('color',$color)
            $ctokens = $color -split ' '
            #write-host ('ct1',$ctokens[0],'ct2',$ctokens[1],$limit.($ctokens[1]))
            $min.($ctokens[1]) = [math]::Max($min.($ctokens[1]),$ctokens[0])
        }
    }
    $mult = $min.red * $min.green * $min.blue
    $sum += $mult
    #pause
} 
$sum