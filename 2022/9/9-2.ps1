#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\9\inputsample.txt"
#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\9\inputsample2.txt"
[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\9\input.txt"

$tailpositions = @()

function Calc-TailMove {
    param (
        $headX,
        $headY,
        $tailX,
        $tailY
    )
    #calculate distance
    $distanceX = $headX - $tailX
    $distanceXAbs = [math]::Abs($distanceX)
    $distanceY = $headY - $tailY
    $distanceYAbs = [math]::Abs($distanceY)
    $distance = $distanceXAbs + $distanceYAbs
    switch ($distance) {
        {$_ -eq 0} {
            #overlap
            #Write-host ('Overlap','HX',$headX ,'HY',$headY,'TX',$tailX,'TY',$tailY,'Dir',$direction,'Dis',$distance)
        }
        {$_ -eq 1} {
            #adjacent hor or vert
            #Write-host ('Adjacent Hor-Ver','HX',$headX ,'HY',$headY,'TX',$tailX,'TY',$tailY,'Dir',$direction,'Dis',$distance)
        }
        {$_ -ge 2} {
            #Write-host ('Move Diagonally','HX',$headX ,'HY',$headY,'TX',$tailX,'TY',$tailY,'Dir',$direction,'Dis',$distance, 'DisX', $distanceX, 'DisY', $distanceY)
            $movec=-1
            switch ($distanceX) {
                {$_ -le -2} {
                    $movec++
                    $tailX--
                    switch ($distanceY) {
                        {$_ -le -1} {$tailY--}
                        {$_ -ge 1} {$tailY++}
                    }
                }
                {$_ -ge 2} {
                    $movec++
                    $tailX++
                    switch ($distanceY) {
                        {$_ -le -1} {$tailY--}
                        {$_ -ge 1} {$tailY++}
                    }
                }
            }
            if ($movec) {
                switch ($distanceY) {
                    {$_ -le -2} {
                        $tailY--
                        switch ($distanceX) {
                            {$_ -le -1} {$tailX--}
                            {$_ -ge 1} {$tailX++}
                        }
                    }
                    {$_ -ge 2} {
                        $tailY++
                        switch ($distanceX) {
                            {$_ -le -1} {$tailX--}
                            {$_ -ge 1} {$tailX++}
                        }
                    }
                }
            }
        }

    }

    #Write-host ('End move','HX',$headX ,'HY',$headY,'TX',$tailX,'TY',$tailY,'Dir',$direction,'Dis',$distance)
    return @{
        X=$tailX
        Y=$tailY
    }

}
$allpositions = @()
for ($i = 0; $i -lt 10; $i++) { 
    $allpositions += @{
        X=[int]0
        Y=[int]0
    }
}
function draw {
    $minx = -20 #($allpositions|%{$_['X']}|sort)[0]
    $maxx = 20 #($allpositions|%{$_['X']}|sort)[-1]
    $minY = -20 #($allpositions|%{$_['Y']}|sort)[0]
    $maxY = 20 #($allpositions|%{$_['Y']}|sort)[-1]
    foreach ($Y in $maxY..$minY) {
        $row = foreach ($X in $minX..$maxX) {
            $values = $null 
            $values = for ($i=0;$i -lt 10;$i++){
                if ($allpositions[$i]['X'] -eq $X -and $allpositions[$i]['Y'] -eq $Y) {
                    if($i){$i}else{'O'}
                }
            }
            if ($values) {
                ($values|sort)[0]
            } else {'.'}
        }
        $row -join ''
    }
}

foreach ($line in $inputdata) {
    $tokens = $line -split ' '
    [string]$direction = $tokens[0]
    [int]$distance = $tokens[1]
    #Write-host ('Start Command', 'Dir',$direction,'Dis',$distance)
    #move head
    for ($i=0;$i -lt $distance;$i++) {
        $headposition = $allpositions[0]
        $tailposition = $allpositions[1]
        #Write-host ('Start Headmove',$i,$j, 'HX',$headposition['X'] ,'HY',$headposition['Y'],'TX',$tailposition['X'],'TY',$tailposition['Y'],'Dir',$direction,'Dis',$distance)
        switch ($direction) {
            {$_ -eq "U"}{$headposition['Y']++}
            {$_ -eq "D"}{$headposition['Y']--}
            {$_ -eq "R"}{$headposition['X']++}
            {$_ -eq "L"}{$headposition['X']--}
        }
        $allpositions[0] = $headposition
        $allpositions[1] = $tailposition
        for ($j=0;$j -lt 9;$j++) {
            $head = $j
            $tail = $j+1
            #Write-Host ('Head',$head,'Tail',$tail)
            $headposition = $allpositions[$head]
            $tailposition = $allpositions[$tail]
            #Write-Host ('Start Tailmove', $i,$j, 'HX',$headposition['X'] ,'HY',$headposition['Y'],'TX',$tailposition['X'],'TY',$tailposition['Y'],'Dir',$direction,'Dis',$distance)
            $tailposition = Calc-TailMove -headx $headposition['X'] -heady $headposition['Y'] -tailx $tailposition['X'] -taily $tailposition['Y']
            $allpositions[$head] = $headposition
            $allpositions[$tail] = $tailposition
        }
        $tailpositions += $allpositions[9]['X'],$allpositions[9]['Y'] -join ','
        
    }
    #draw
    #pause
}
$tailpositions|select -unique|measure