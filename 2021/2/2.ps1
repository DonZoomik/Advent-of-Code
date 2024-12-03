[string[]]$data = gc C:\aoc\2021\2\data.txt
$x = 0 #forward, horizontal
$y = 0 #depth, vertical
$aim = 0
foreach ($row in $data) {
    $tokens = $row -split ' '
    $direction = $tokens[0]
    [int]$size = $tokens[1]
    switch ($direction) {
        up { $aim = $aim - $size}
        down {$aim = $aim + $size}
        forward {
            $x = $x + $size
            $y = $y + ($size * $aim)
        }
    }
}
($x, $y, $aim, ($x * $y))