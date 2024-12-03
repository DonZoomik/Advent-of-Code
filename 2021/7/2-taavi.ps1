measure-command {[int[]]$data = (gc C:\aoc\2021\7\input.txt) -split ','
$spentfuel=@()
$min = ($data|measure -Minimum).Minimum
$max = ($data|measure -Maximum).Maximum
$spentfuel = for ($i=$min;$i -lt $max;$i++){
    #write-host ($i)
    $fuel=0
    for ($j=0;$j -lt $data.Count;$j++){

        $fuel1 = [math]::Abs($i-$data[$j])
        $fuel2 = ($fuel1*($fuel1+1))/2
        $fuel = $fuel+$fuel2
        #write-host ('depth', $i, 'index', $j,'data', $data[$j],'steps', $fuel1,'stepcost', $fuel2,'total', $fuel)
    }
    $fuel
}
}
($spentfuel|measure -Minimum).Minimum