#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\9\inputsample.txt"
[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\9\input.txt"

$headposition = @{
    X=[int]0
    Y=[int]0
}
$tailposition = @{
    X=[int]0
    Y=[int]0
}
$tailpositions = @()
$tailpositions += $tailposition['X'],$tailposition['Y'] -join ','

function Calc-TailMove {
    param (
        $direction,
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
        {$_ -eq 2} {
            #1 away hor or vert or adj diagonally
            if ($distanceXAbs -eq $distanceYAbs) {
                #Write-host ('Adjacent Diagonally','HX',$headX ,'HY',$headY,'TX',$tailX,'TY',$tailY,'Dir',$direction,'Dis',$distance)
            #2 way straight
            } else {
                #Write-host ('Move Straight','HX',$headX ,'HY',$headY,'TX',$tailX,'TY',$tailY,'Dir',$direction,'Dis',$distance)
                switch ($direction) {
                    {$_ -eq 'U'}{$tailY++}
                    {$_ -eq 'D'}{$tailY--}
                    {$_ -eq 'R'}{$tailX++}
                    {$_ -eq 'L'}{$tailX--}
                }
            }
        }
        {$_ -eq 3} {
            #Write-host ('Move Diagonally','HX',$headX ,'HY',$headY,'TX',$tailX,'TY',$tailY,'Dir',$direction,'Dis',$distance)
            #determine secondary move
            switch ($direction) {
                {$_ -in @('U','D')}{
                    #determine if left or right
                    switch ($distanceX) {
                        {$_ -eq -1} {
                            #tail is on left
                            $tailX--
                        }
                        {$_ -eq 1} {
                            #tail is on right
                            $tailX++
                        }
                    }
                }
                {$_ -in @('R','L')}{
                    switch ($distanceY) {
                        {$_ -eq -1} {
                            #tail is above
                            $tailY--
                        }
                        {$_ -eq 1} {
                            #tail is below
                            $tailY++
                        }
                    }
                }
            }
            switch ($direction) {
                {$_ -eq 'U'}{$tailY++}
                {$_ -eq 'D'}{$tailY--}
                {$_ -eq 'R'}{$tailX++}
                {$_ -eq 'L'}{$tailX--}
            }
        }

    }

    #Write-host ('End move','HX',$headX ,'HY',$headY,'TX',$tailX,'TY',$tailY,'Dir',$direction,'Dis',$distance)
    return @{
        X=$tailX
        Y=$tailY
    }

}

foreach ($line in $inputdata) {
    $tokens = $line -split ' '
    [string]$direction = $tokens[0]
    [int]$distance = $tokens[1]
    #Write-host ('Start Command', 'HX',$headposition['X'] ,'HY',$headposition['Y'],'TX',$tailposition['X'],'TY',$tailposition['Y'],'Dir',$direction,'Dis',$distance)
    #move head
    for ($i=0;$i -lt $distance;$i++) {
        #Write-host ('Start Headmove',$i, 'HX',$headposition['X'] ,'HY',$headposition['Y'],'TX',$tailposition['X'],'TY',$tailposition['Y'],'Dir',$direction,'Dis',$distance)
        switch ($direction) {
            {$_ -eq "U"}{$headposition['Y']++}
            {$_ -eq "D"}{$headposition['Y']--}
            {$_ -eq "R"}{$headposition['X']++}
            {$_ -eq "L"}{$headposition['X']--}
        }
        #Write-Host ('Start Tailmove', $i, 'HX',$headposition['X'] ,'HY',$headposition['Y'],'TX',$tailposition['X'],'TY',$tailposition['Y'],'Dir',$direction,'Dis',$distance)
        $tailposition = Calc-TailMove -Direction $direction -headx $headposition['X'] -heady $headposition['Y'] -tailx $tailposition['X'] -taily $tailposition['Y']
        $tailpositions += $tailposition['X'],$tailposition['Y'] -join ','
    }
}
$tailpositions|select -unique|measure