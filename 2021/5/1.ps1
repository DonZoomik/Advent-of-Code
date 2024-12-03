[string[]]$data = gc C:\aoc\2021\5\input.txt
$lines = @()
foreach ($row in $data) {
    $ends=$row -split ' -> '
    $end1 = $ends[0]
    $end2 = $ends[1]
    $end1components = $end1 -split ','
    $end2components = $end2 -split ','
    $lines += [PSCustomObject] @{
        x1 = [int]$end1components[0]
        y1 = [int]$end1components[1]
        x2 = [int]$end2components[0]
        y2 = [int]$end2components[1]
    }
}
$xmaximums= $(
    ($lines.x1|measure -Maximum).Maximum
    ($lines.x2|measure -Maximum).Maximum
)
$xlimit = ($xmaximums|measure -Maximum).maximum
$ymaximums= $(
    ($lines.y1|measure -Maximum).Maximum
    ($lines.y2|measure -Maximum).Maximum
)
$ylimit = ($ymaximums|measure -Maximum).maximum

$grid = New-Object 'int[][]' ($xlimit+1),($ylimit+1)

foreach ($line in $lines) {
    switch ($line) {
        {$_.x1 -eq $_.x2 -and $_.y1 -ne $_.y2} {
            #write-host linex
            $min = [math]::Min($_.y1,$_.y2)
            $max = [math]::Max($_.y1,$_.y2)
            #write-host ($_, $min, $max)
            #first coordinate must be Y, then we'll have the same view
            for ($i = $min; $i -le $max; $i++) {
                $grid[$i][$_.x1]++
                #write-host ($_.x1, $i, $grid[$i][$_.x1])
            }
        }
        {$_.y1 -eq $_.y2 -and $_.x1 -ne $_.x2} {
            #write-host liney
            $min = [math]::Min($_.x1,$_.x2)
            $max = [math]::Max($_.x1,$_.x2)
            #write-host ($_, $min, $max)
            for ($i = $min; $i -le $max; $i++) {
                $grid[$_.y1][$i]++
                #write-host ($_.y1, $i, $grid[$_.y1][$i])
            }
        }
        default {
            $xrange = $_.x1..$_.x2
            $yrange = $_.y1..$_.y2
            #write-host ($_, $min, $max)
            for ($i = 0; $i -lt $xrange.count; $i++) {
                $grid[$yrange[$i]][$xrange[$i]]++
                #write-host ($_, $i, $xrange[$i], $yrange[$i], $grid[$yrange[$i]][$xrange[$i]])
            }
            #pause
        }
    }
}
#$grid| % { $_ -join '' }
($grid| % { $_ |? {$_ -gt 1}}|measure).count