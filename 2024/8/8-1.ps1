#$data = gc "C:\aoc\Advent-of-Code\2024\8\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\8\data.txt"
#$data = gc "C:\aoc\Advent-of-Code\2024\8\data2.txt"

$height = $data.Count
$width = $data[0].ToCharArray().Count
$matrix = New-Object 'object[,]' $height,$width

$chars = for ($y=0;$y -lt $height;$y++){
    $row = $data[$y].ToCharArray()
    for ($x=0;$x -lt $width;$x++) {
        $matrix[$y,$x] = $row[$x]
        if ($row[$x] -ne '.') {
            [PSCustomObject]@{
                x = $x
                y = $y
                v = $row[$x]
            }
        }
    }
}

function printmatrix {
    for ($y=0;$y -lt $height;$y++) {
        write-host $((0..($width-1)|%{$matrix[$y,$_]}) -join'')
    }
}
function comparematrix {
    for ($y=0;$y -lt $height;$y++) {
        for ($x=0;$x -lt $width;$x++) {
            if ($matrix[$y,$x] -ne $data2[$y][$x]) {
                write-host "$x $y $($matrix[$y,$x]) $($data2[$y][$x])"
            }
        }
    }
}

function testinmap {
    param(
        $x,
        $y
    )
    if ($x -ge 0 -and $x -lt $width -and $y -ge 0 -and $y -lt $height) {
        return $true
    } else {
        return $false
    }
}

function buildpairs {
    param ($values)
    $pairs = for($i=0; $i -lt ($values.Count); $i++){
        for($j=$i+1; $j -lt ($values.Count); $j++){
            #write-host "$($values.count) $i $j"
            ,(@($values[$i], $values[$j]))
        }
    }
    #write-host $values
    #write-host $pairs
    return $pairs
}
function buildantipoints {
    param($values)
    $distancex = [math]::Abs($values[0].x - $values[1].x)
    $distancey = [math]::Abs($values[0].y - $values[1].y)
    if ($values[0].x -ge $values[1].x) {
        $antipoint1x = $values[0].x + $distancex
        $antipoint2x = $values[1].x - $distancex
    } else {
        $antipoint1x = $values[0].x - $distancex
        $antipoint2x = $values[1].x + $distancex
    }
    
    if ($values[0].y -ge $values[1].y) {
        $antipoint1y = $values[0].y + $distancey
        $antipoint2y = $values[1].y - $distancey
    } else {
        $antipoint1y = $values[0].y - $distancey
        $antipoint2y = $values[1].y + $distancey
    }
    if (($values[0].x + $distancex -eq 20 -and $values[0].y + $distancey -eq 26) -or 
        ($values[1].x + $distancex -eq 20 -and $values[1].y + $distancey -eq 26) -or
        ($values[0].x - $distancex -eq 20 -and $values[0].y - $distancey -eq 26) -or
        ($values[1].x - $distancex -eq 20 -and $values[1].y - $distancey -eq 26) -or 
        ($values[0].x + $distancex -eq 20 -and $values[0].y - $distancey -eq 26) -or
        ($values[0].x - $distancex -eq 20 -and $values[0].y + $distancey -eq 26) -or
        ($values[1].x + $distancex -eq 20 -and $values[1].y - $distancey -eq 26) -or
        ($values[1].x - $distancex -eq 20 -and $values[1].y + $distancey -eq 26)
    ) {
        write-host $values
        pause
    }
    return @(
        [PSCustomObject]@{
            x = $antipoint1x
            y = $antipoint1y
            v = $values[0].v
        },
        [PSCustomObject]@{
            x = $antipoint2x
            y = $antipoint2y
            v = $values[0].v
        }
    )
}
$antipoints = $()

$cgroups = $chars|group v -CaseSensitive|? count -ge 2|sort name
$uchars = $cgroups.name
$antipoints = foreach ($cgroup in $cgroups) {
    $pairs = buildpairs -values $cgroup.Group
    #write-host "$($cgroup.Count) $($pairs.count)"
    #pause
    foreach ($pair in $pairs) {
        $aps = buildantipoints -values $pair
        foreach ($ap in $aps) {
            if (testinmap -x $ap.x -y $ap.y ) {
                <#if ($matrix[$ap.y,$ap.x] -eq '.') {
                    $matrix[$ap.y,$ap.x] = '#'
                } elseif ($matrix[$ap.y,$ap.x] -eq '#') {
                    $matrix[$ap.y,$ap.x] = '*'
                } elseif ($matrix[$ap.y,$ap.x] -cin $uchars) {
                    $matrix[$ap.y,$ap.x] = '/'
                } elseif ($matrix[$ap.y,$ap.x] -eq '/') {
                    $matrix[$ap.y,$ap.x] = '\'
                }#>
                $matrix[$ap.y,$ap.x] = '#'
                $ap
            }
        }
    }
}


printmatrix
($uchars|sort)-join''
($antipoints|select x,y -unique|measure).count
($antipoints|measure).count
$matrix|?{$_ -match '#|\*|\/|\\'}|measure

$data2 = (gc "C:\aoc\Advent-of-Code\2024\8\data3.txt")-join'' |ConvertFrom-Json
comparematrix

$data|%{$_.ToCharArray()}|?{$_ -ne '.'}|measure
$chars.count
