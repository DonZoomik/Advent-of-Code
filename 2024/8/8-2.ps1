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
    #write-host $values
    $distancex = [math]::Abs($values[0].x - $values[1].x)
    $distancey = [math]::Abs($values[0].y - $values[1].y)

    if ($values[0].x -lt $values[1].x) {
        $antipoint1x = $values[0].x + $distancex
        $antipoint2x = $values[1].x - $distancex
    } else {
        $antipoint1x = $values[0].x - $distancex
        $antipoint2x = $values[1].x + $distancex
    }
    
    if ($values[0].y -lt $values[1].y) {
        $antipoint1y = $values[0].y + $distancey
        $antipoint2y = $values[1].y - $distancey
    } else {
        $antipoint1y = $values[0].y - $distancey
        $antipoint2y = $values[1].y + $distancey
    }
    $baps = @(
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

    $break = $true
    while($break) {
        $inmap1 = $true
        $inmap2 = $true
        if ($values[0].x -lt $values[1].x) {
            $antipoint1x = $antipoint1x + $distancex
            $antipoint2x = $antipoint2x - $distancex
        } else {
            $antipoint1x = $antipoint1x - $distancex
            $antipoint2x = $antipoint2x + $distancex
        }
        
        if ($values[0].y -lt $values[1].y) {
            $antipoint1y = $antipoint1y + $distancey
            $antipoint2y = $antipoint2y - $distancey
        } else {
            $antipoint1y = $antipoint1y - $distancey
            $antipoint2y = $antipoint2y + $distancey
        }
        if (testinmap -x $antipoint1x -y $antipoint1y) {
            $baps += [PSCustomObject]@{
                x = $antipoint1x
                y = $antipoint1y
                v = $values[0].v
            }
        } else {
            $inmap1 = $false
            #write-host out1
        }
        if (testinmap -x $antipoint2x -y $antipoint2y) {
            $baps += [PSCustomObject]@{
                x = $antipoint2x
                y = $antipoint2y
                v = $values[0].v
            }
        } else {
            $inmap2 = $false
            #write-host out2
        }
        if (!$inmap1 -and !$inmap2){$break=$false}
    }
    #pause
    return $baps
}
$antipoints = $()

$cgroups = $chars|group v|? count -ge 2
$uchars = $cgroups.name
$antipoints = foreach ($cgroup in $cgroups) {
    $pairs = buildpairs -values $cgroup.Group
    #write-host "$($cgroup.Count) $($pairs.count)"
    #pause
    foreach ($pair in $pairs) {
        $aps = buildantipoints -values $pair
        foreach ($ap in $aps) {
            if (testinmap -x $ap.x -y $ap.y ) {
                if ($matrix[$ap.y,$ap.x] -eq '.') {
                    $matrix[$ap.y,$ap.x] = '#'
                } <#elseif ($matrix[$ap.y,$ap.x] -eq '#') {
                    $matrix[$ap.y,$ap.x] = '*'
                } elseif ($matrix[$ap.y,$ap.x] -cin $uchars) {
                    $matrix[$ap.y,$ap.x] = '/'
                } elseif ($matrix[$ap.y,$ap.x] -eq '/') {
                    $matrix[$ap.y,$ap.x] = '\'
                }#>
                #$matrix[$ap.y,$ap.x] = '#'
                $ap
            }
        }
    }
    #printmatrix
    #pause
}


printmatrix
#($uchars|sort)-join''
($antipoints|select x,y -unique|measure).count
#($antipoints|measure).count
($matrix|?{$_ -ne '.'}|measure).count
<#
$data2 = (gc "C:\aoc\Advent-of-Code\2024\8\data3.txt")-join'' |ConvertFrom-Json
comparematrix

$data|%{$_.ToCharArray()}|?{$_ -ne '.'}|measure
$chars.count
#>
#$matrix[26,20]