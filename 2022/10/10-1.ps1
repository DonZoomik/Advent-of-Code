#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\10\input1.txt"
[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\10\input2.txt"
#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\10\input3.txt"

$register = @{
    X = [int]1
}
$clock = 0
$pixel = 0
$breakpoints = (20, 60, 100, 140, 180, 220)
[string]$row=''

$cycles=for ($i=0;$i -le $inputdata.Count;$i++) {
    $tokens = $inputdata[$i] -split ' '
    switch ($tokens[0]) {
        'noop' {$clockdiff=1}
        'addx' {$clockdiff=2}
    }
    for ($j=0;$j -lt $clockdiff;$j++) {
        if ($register['X'] -in @(($pixel - 1),$pixel,($pixel + 1))) {
            $row = $row,'#' -join ''
        } else {
            $row = $row,'.' -join ''
        }
        $clock++
        $pixel++
        if ($pixel -eq 40) {
            $pixel = 0
            write-host $row
            [string]$row=''
        }
        #write-host ('clock',$clock,'row',$i,'command',$tokens[0],'delay',$clockdiff,'diff',$j,'register',$register['X'])
        if ($clock -in $breakpoints) {
            $clock * $register['X']
        }

    }
    switch ($tokens[0]) {
        'addx' {
            $register['X']+=$tokens[1]
            #write-host ('clock',$clock,'register',$register['X'])
        }
    }
}
$cycles|measure -sum