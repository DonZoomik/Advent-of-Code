#$data = gc "C:\aoc\Advent-of-Code\2024\6\test.txt"
    $data = gc "C:\aoc\Advent-of-Code\2024\6\data.txt"

$height = $data.Count
$width = $data[0].ToCharArray().Count

$matrix = New-Object 'object[,]' $width,$height

for ($y=0;$y -lt $height;$y++){
    $row = $data[$y].ToCharArray()
    $sp = ($row-join'').IndexOf('^')
    if ($sp -ge 0){
        [pscustomobject]$position = @{
            x=$sp
            y=$y
            d='U'
            s=0
        }
    }
    for ($x=0;$x -lt $width;$x++) {
        $matrix[$y,$x] = $row[$x]
    }
}

function printmatrix {
    for ($y=0;$y -lt $height;$y++) {
        write-host $((0..($width-1)|%{$matrix[$y,$_]}) -join'')
    }
}
function testmatch {
    param (
        $x,
        $y,
        $d
    ) 
    if ($positions|?{$_.x -eq $x -and $_.y -eq $y -and $_.d -match $d}) {
        return $true
    } else {
        return $false
    }
}
<#
#$positions|?{$_.x -eq 6 -and $_.y -eq 6}
printmatrix
testmatch -x 2 -y 4 -d 'U|L'
rightmatch -currentx 2 -currenty 8 -dir 'U' 
rightmatch -currentx 1 -currenty 1 -dir 'R'
rightmatch -currentx 4 -currenty 8 -dir 'U'
#>
function rightmatch{
    param(
        $currentx,
        $currenty,
        $dir
    )
    switch ($dir) {
        'L' {
            $hasmatch = -1
            $row = 0..($width-1)|%{$matrix[$currenty,$_]}
            for ($i=$currentx;$i -ge 0;$i--) {
                #write-host $row[$i]
                if ($row[$i] -eq '#') {
                    $hasmatch = $i
                    break
                }
            }
            #write-host $($row -join'')
            #write-host "L $hasmatch X $currentx Y $currenty"
            if ($hasmatch -lt $currentx -and $hasmatch -ge 0) {
                #write-host "L $currenty $currentx X $hashmatch U"
                if (testmatch -x ($hasmatch+1) -y $currenty -d 'U|L') {
                    #write-host $true
                    return $true
                    break
                } else {
                    #write-host $false
                }
            }
        }
        'R' {
            $hasmatch = -1
            $row = 0..($width-1)|%{$matrix[$currenty,$_]}
            for ($i=$currentx;$i -lt $width;$i++) {
                if ($row[$i] -eq '#') {
                    $hasmatch = $i
                    break
                }
            }
            if ($hasmatch -gt $currentx) {
                #write-host "R $currenty $currentx X $hashmatch D"
                if (testmatch -x ($hasmatch-1) -y $currenty -d 'R|D') {
                    return $true
                }
            }
        }
        'U' {
            $hasmatch= -1
            $row = 0..($height-1)|%{$matrix[$_,$currentx]}
            
            for ($i=$currenty;$i -ge 0;$i--) {
                #write-host $row[$i]
                if ($row[$i] -eq '#') {
                    $hasmatch = $i
                    break
                }
            }
            #write-host $($row -join'')
            #write-host "U $hasmatch X $currentx Y $currenty"
            #write-host $($hasmatch -lt $currenty)
            #write-host $($hasmatch -ge 0)
            if ($hasmatch -lt $currenty -and $hasmatch -ge 0) {
                if (testmatch -x $currentx -y ($hasmatch+1) -d 'U|R') {
                    #write-host "Loop $true"
                    return $true
                } else {
                    #write-host $false
                }
            }
        }
        'D' {
            $hasmatch= -1
            $row = 0..($height-1)|%{$matrix[$_,$currentx]}
            for ($i=$currenty;$i -lt $height;$i++) {
                if ($row[$i] -eq '#') {
                    $hasmatch = $i
                    break
                }
            }
            #write-host "$hashmatch Y $currenty"
            #write-host $($hashmatch -gt $currenty)
            #write-host $($hashmatch -ge 0)
            if ($hasmatch -gt $currenty) {
                #write-host "D $currenty $currentx Y $hashmatch $currentx L"
                #write-host $hashmatch
                if (testmatch -x $currentx -y ($hasmatch-1) -d 'D|L') {
                    return $true
                }
            }
        }  
    }
    return $false
}
$currenty = 0

$positions = @()
$blocks = @()
$start = $position.Clone()

while (
    $position.x -ge 0 -and
    $position.y -ge 0 -and
    $position.x -lt $width -and
    $position.y -lt $height
) {
    $positions += [pscustomobject]$position
    $position.s++
    $prevhit = $null
    $currentx = $position.x
    $currenty = $position.y
    $currentd = $position.d
    $currentv = $matrix[$currenty,$currentx]
    switch ($position.d) {
        'U' {
            $nextx = $currentx
            $nexty = $currenty-1
            $turnd = 'R'
            $turnx = $currentx+1
            $turny = $currenty
            $turnd2= 'D'
            $turnx2 = $turrentx
            $turny2 = $currenty+1
        }
        'R' {
            $nextx = $currentx+1
            $nexty = $currenty
            $turnd = 'D'
            $turnx = $currentx
            $turny = $currenty+1
            $turnd2 = 'L'
            $turnx2 = $currentx-1
            $turny2 = $currenty
        }
        'D' {
            $nextx = $currentx
            $nexty = $currenty+1
            $turnd = 'L'
            $turnx = $currentx-1
            $turny = $currenty
            $turnd2 = 'U'
            $turnx2 = $currentx
            $turny2 = $currenty-1
        }
        'L' {
            $nextx = $currentx-1
            $nexty = $currenty
            $turnd = 'U'
            $turnx = $currentx
            $turny = $currenty-1
            $turnd2 = 'R'
            $turnx2 = $currentx+1
            $turny2 = $currenty
        }

    }
    $nextv = $matrix[$nexty,$nextx]
    $loophit = rightmatch -currentx $currentx -currenty $currenty -dir $turnd
    $loophit2 = rightmatch -currentx $currentx -currenty $currenty -dir $turnd2
    $starthit = $nextx -eq $start.x -and $nexty -eq $start.y
    $starthit2 = $turnx -eq $start.x -and $turny -eq $start.y
    #Write-host "LH $loophit SH $starthit"
    if ($nextv -eq '#' -and $currentv -notmatch 'X|O') {
        $matrix[$currenty,$currentx] = 'X'
        $position.d = $turnd
        $position.x = $turnx
        $position.y = $turny
    } elseif ($nextv -eq '#' -and $currentv -match 'X|O')  {
        $position.d = $turnd
        $position.x = $turnx
        $position.y = $turny
    } elseif ($nextv -eq '#' -and $loophit2 -and !$starthit2){
        $matrix[$turny,$turnx] = 'O'
        if ($currentv -notmatch 'X|O') {$matrix[$currenty,$currentx] = 'X'}
        $position.x = $nextx2
        $position.y = $nexty2
        $blocks += $position
    } elseif ($nextv -ne '#' -and $loophit -and !$starthit){
        $matrix[$nexty,$nextx] = 'O'
        if ($currentv -notmatch 'X|O') {$matrix[$currenty,$currentx] = 'X'}
        $position.x = $nextx
        $position.y = $nexty
        $blocks += $position
    } elseif ($currentv -eq 'O') {
        $position.x = $nextx
        $position.y = $nexty
    } else {
        $matrix[$currenty,$currentx] = 'X'
        $position.x = $nextx
        $position.y = $nexty
    }
    #printmatrix
    #write-host " "
    #pause
}

$matrix|? {$_ -match 'X|O'}|measure
$matrix|? {$_ -eq 'O'}|measure
