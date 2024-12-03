$data = gc C:\aoc2023\4\input.txt
$sum = 0
$games= @{}
for ($i=0;$i -lt $data.Count;$i++){
    $games.add($i,1)
}

for ($i=0;$i -lt $data.Count;$i++){
    $tokens1 = $data[$i] -split "\:\s+"
    $game = [int]::Parse( ($tokens1[0].trim() -split "\s+")[1] )
    $tokens2 = $tokens1[1].trim() -split "\s+\|\s+"
    $winnumbers = $tokens2[0] -split "\s+"|%{[int]::Parse($_)}
    $chosennumbers = $tokens2[1] -split "\s+"|%{[int]::Parse($_)}   
    $winmatches=0
    foreach ($chosennumber in $chosennumbers) {
        if ($chosennumber -in $winnumbers) {
            $winmatches++
        }
    }
    for ($j=0;$j -lt $games[$game];$j++) {
        for ($k=1;$k -le $winmatches;$k++) {
            $games[$game+$k]++
        }
    }

    write-host ('row',$i,'match',$winmatches,'points',$points)
    $sum += $points
}
$games.Values|measure -sum
