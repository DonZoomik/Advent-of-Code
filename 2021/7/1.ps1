[int[]]$data = (gc C:\aoc\2021\7\input.txt) -split ','
$spentfuel=@()
for ($i=0;$i -lt $data.Count;$i++){
    $fuel = 0
    for ($j=0;$j -lt $data.Count;$j++){
        $fuel = $fuel + [math]::Abs($data[$i]-$data[$j])
    }
    $spentfuel += $fuel
}
($spentfuel|measure -Minimum).Minimum