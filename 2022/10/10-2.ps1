[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\10\input1.txt"
#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\10\input2.txt"

$register = @{
    X = [int]1
}
$clock = 0
$breakpoints = (20, 60, 100, 140, 180, 220)

for ($i=0;$i -le $inputdata.Count;$i++) {
    $tokens = $inputdata[$i] -split ' '
    switch ($tokens[0]) {
        'noop' {$clockdiff=1}
        'addx' {$clockdiff=2}
    }
    for ($j=0;$j -lt $clockdiff;$j++) {
        $clock++
        write-host ('clock',$clock,'row',$i,'command',$tokens[0],'delay',$clockdiff,'diff',$j,'register',$register['X'])
        if ($clock -in $breakpoints) {
            $clock * $register['X']
        }
    }
    switch ($tokens[0]) {
        'addx' {$register['X']+=$tokens[1]}
    }
}