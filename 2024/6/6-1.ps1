#$data = gc "C:\aoc\Advent-of-Code\2024\6\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\6\data.txt"

$matrix = $data|%{
    ,[char[]]($_.ToCharArray())
}

$width = $matrix[0].Count
$height = $matrix.Count

for ($y=0;$y -lt $height;$y++){
    $x = ($matrix[$y]-join'').IndexOf('^')
    if ($x -ge 0){
        $position = @{
            x=$x
            y=$y
        }
        break
    }
}
$matrix[$position.y][$position.x] = 'X'

$dir = 'up'

$positions = @()

while (
    $position.x -ge 0 -and
    $position.y -ge 0 -and
    $position.x -lt ($width-1) -and
    $position.y -lt ($height-1)
) {
    $positions += $position
    switch ($dir) {
        'up' {
            if ($matrix[$position.y-1][$position.x] -eq '#') {
                $dir = 'right'
                $position.x++
            } else {
                $position.y--
            }
            $matrix[$position.y][$position.x] = 'X'
        }
        'down' {
            if ($matrix[$position.y+1][$position.x] -eq '#') {
                $dir = 'left'
                $position.x--
            } else {
                $position.y++
            }
            $matrix[$position.y][$position.x] = 'X'
        }
        'left' {
            if ($matrix[$position.y][$position.x-1] -eq '#') {
                $dir = 'up'
                $position.y--
            } else {
                $position.x--
            }
            $matrix[$position.y][$position.x] = 'X'
        }
        'right' {
            if ($matrix[$position.y][$position.x+1] -eq '#') {
                $dir = 'down'
                $position.y++
            } else {
                $position.x++
            }
            $matrix[$position.y][$position.x] = 'X'
        }
    }
    #$matrix|%{$_-join''|write-host}
    "'D',$dir,'X',$($position.x),'Y',$($position.y)'PC',$($positions.Count)"|Write-Host
    #pause
}
$positions2=0
$matrix|%{
    $_|%{
        if ($_ -eq 'X') {$positions2++}
    }
}
$positions2