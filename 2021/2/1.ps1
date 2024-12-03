[string[]]$data = gc C:\aoc\2021\2\data.txt
$x = 0 #forward
$y = 0 #depth
foreach ($row in $data) {
    $tokens = $row -split ' '
    $direction = $tokens[0]
    [int]$size = $tokens[1]
    switch ($direction) {
        up { $y = $y - $size}
        down {$y = $y + $size}
        forward {$x = $x + $size}
    }
}
($x, $y, ($x * $y))