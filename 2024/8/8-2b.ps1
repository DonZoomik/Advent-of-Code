#$data = gc "C:\aoc\Advent-of-Code\2024\8\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\8\data.txt"
#$data = gc "C:\aoc\Advent-of-Code\2024\8\data2.txt"

$height = $data.Count
$width = $data[0].ToCharArray().Count
$matrix = New-Object 'object[,]' $height,$width
$antipoints = @()
$chars = for ($y=0;$y -lt $height;$y++){
    $row = $data[$y].ToCharArray()
    for ($x=0;$x -lt $width;$x++) {
        $matrix[$y,$x] = $row[$x]
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
    #write-host $values
    #write-host "$distancex $distancey"
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
    #write-host "$antipoint1x $antipoint1y"
    if (testinmap -x $antipoint1x -y $antipoint1y) {
        $global:antipoints += ,[PSCustomObject]@{
            x = $antipoint1x
            y = $antipoint1y
            v = $values[0].v
        }
    }
    if (testinmap -x $antipoint2x -y $antipoint2y) {
        $global:antipoints += ,[PSCustomObject]@{
            x = $antipoint2x
            y = $antipoint2y
            v = $values[0].v
        }
    }
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
            $global:antipoints += [PSCustomObject]@{
                x = $antipoint1x
                y = $antipoint1y
                v = $values[0].v
            }
        } else {
            $inmap1 = $false
            #write-host out1
        }
        if (testinmap -x $antipoint2x -y $antipoint2y) {
            $global:antipoints += [PSCustomObject]@{
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
}
function findothers {
    param (
        $current
    )
    for ($y=0;$y -lt $height;$y++) {
        for ($x=0;$x -lt $width;$x++) {
            if ($matrix[$y,$x] -ceq $current.v -and $x -ne $current.x -and $y -ne $current.y) {
                buildantipoints -values @($current,
                [PSCustomObject]@{
                    x = $x
                    y = $y
                    v = $current.v
                }
                )
            }
        }
    }
}

for ($y=0;$y -lt $width;$y++) {
    for ($x=0;$x -lt $height;$x++) {
        if ($matrix[$y,$x] -ne '.') {
            findothers -current (
                [PSCustomObject]@{
                    x = $x
                    y = $y
                    v = $matrix[$y,$x]
                }
            )
        }
    }
}


#printmatrix
#($uchars|sort)-join''
($antipoints|select x,y -unique|measure).count
#($antipoints|measure).count
#$matrix|?{$_ -match '#|\*|\/|\\'}|measure

#$data2 = (gc "C:\aoc\Advent-of-Code\2024\8\data3.txt")-join'' |ConvertFrom-Json
#comparematrix

#$data|%{$_.ToCharArray()}|?{$_ -ne '.'}|measure
#$chars.count
