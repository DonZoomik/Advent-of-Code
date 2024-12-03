[string[]]$inputdata = gc "C:\Users\mihkel.soomere\OneDrive\AoC\2022\2\input.txt"|%($_){$_}
[int]$score = 0
$cost = @{
    A = 1
    B = 2
    C = 3
    X = 1
    Y = 2
    Z = 3
}
$data = foreach ($line in $inputdata) {
    [string[]]$tokens = $line.trim() -split ' '
    [int]$win = [int]$cost[$tokens[1]] - [int]$cost[$tokens[0]]
    switch ($win) {
        {$_ -eq -1 -or $_ -eq 2} {
            $round = $cost[$tokens[1]]
            [char]$R = 'L'
        }
        {$_ -eq 1 -or $_ -eq -2} {
            $round = $cost[$tokens[1]] + 6
            [char]$R = 'W'
        }
        default {
            $round = $cost[$tokens[1]] + 3
            [char]$R = 'D'
        }
    }
    $score += $round
    [pscustomobject]@{
        Tok0 = $tokens[0]
        Val0 = $cost[$tokens[0]]
        Tok1 = $tokens[1]
        Val1 = $cost[$tokens[1]]
        Sub = $win
        Rou = $round
        Res = $R
        Sco = $score
    }
}
$data | ft -AutoSize
write-host $score