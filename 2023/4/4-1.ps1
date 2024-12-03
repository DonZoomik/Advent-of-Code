$data = gc C:\aoc2023\4\input.txt
$sum = 0

for ($i=0;$i -lt $data.Count;$i++){
    $tokens1 = $data[$i] -split "\:\s+"
    $game = [int]::Parse( ($tokens1[0].trim() -split "\s+")[1] )
    $tokens2 = $tokens1[1].trim() -split "\s+\|\s+"
    $winnumbers = $tokens2[0] -split "\s+"|%{[int]::Parse($_)}
    $chosennumbers = $tokens2[1] -split "\s+"|%{[int]::Parse($_)}
    $winmatches=$points=0
    foreach ($chosennumber in $chosennumbers) {
        if ($chosennumber -in $winnumbers) {
            $winmatches++
        }
    }
    if ($winmatches -ge 1) {
        $points = [math]::Pow(2,$winmatches-1)
    }
    write-host ('row',$i,'match',$winmatches,'points',$points)
    $sum += $points
}
$sum
