[int[]]$data = (gc C:\aoc\2021\7\input.txt) -split ','
$spentfuel=@()
$min = ($data|measure -Minimum).Minimum
$max = ($data|measure -Maximum).Maximum
for ($i=$min;$i -lt $max;$i++){
    write-host ($i)
    $fuel=0
    for ($j=0;$j -lt $data.Count;$j++){
        #write-host ($i,$j)
        $fuel1 = [math]::Abs($i-$data[$j])
        $fuel2 = 0
        for ($k = 1; $k -le $fuel1; $k++) {
            $fuel2 = $fuel2 + $k
        }
        $fuel = $fuel+$fuel2
        #write-host ('depth', $i, 'index', $j,'data', $data[$j],'steps', $fuel1,'stepcost', $fuel2,'total', $fuel)
    }
    $spentfuel += $fuel
}
($spentfuel|measure -Minimum).Minimum