$data = (gc C:\aoc\2015\1\input.txt).ToCharArray()
$floor=0
for ($i=0;$i -lt $data.Length;$i++){
    switch ($data[$i]) {
        '(' {$floor++}
        ')' {$floor--}
    }
    if ($floor -lt 0) {
        ($i+1)
        pause
    }
}