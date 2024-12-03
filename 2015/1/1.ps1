$data = gc C:\aoc\2015\1\input.txt
$floor=0
foreach ($char in $data.ToCharArray()){
    switch ($char) {
        '(' {$floor++}
        ')' {$floor--}
    }
}
$floor