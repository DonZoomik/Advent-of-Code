[string[]]$data = gc C:\aoc\2021\3\input.txt
$size=$data[0].ToCharArray().Count
$counter = New-Object int[] $size

foreach ($row in $data) {
    for ($i=0;$i -lt $size;$i++) {
        [char[]]$chararray = $row.ToCharArray()
        if ($chararray[$i] -eq '0') {
            #($row, $i, $chararray[$i], $counter[$i], '+')
            $counter[$i]++
        } else {
            #($row, $i, $chararray[$i], $counter[$i])
        }
    }
}

[string]$gamma = ''
[string]$epsilon = ''
foreach ($position in $counter) {
    if ($position -gt ($data.Length / 2)) {
        $gamma = $gamma + '0'
        $epsilon = $epsilon + '1'
        #($position, $data.Length)
    } else {
        $gamma = $gamma + '1'
        $epsilon = $epsilon + '0'
        #($position, $data.Length)
    }
}
$gamma, $epsilon
[convert]::ToInt32($gamma,2), [convert]::ToInt32($epsilon,2)
[convert]::ToInt32($gamma,2) * [convert]::ToInt32($epsilon,2)