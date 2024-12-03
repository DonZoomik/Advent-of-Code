measure-command {
$cost = @{
    A = 1
    B = 2
    C = 3
    X = 1
    Y = 2
    Z = 3
}
[int]$score = 0
$data = foreach ($line in gc "C:\Users\mihkel.soomere\OneDrive\AoC\2022\2\input.txt") {
    [string[]]$tokens = $line.trim() -split ' '
    [int]$win = [int]$cost[$tokens[1]] - [int]$cost[$tokens[0]]
    switch ($win) {
        {$_ -in @(-1,2)} {
            $round = $cost[$tokens[1]]
        }
        {$_ -in @(1,-2)}{
            $round = $cost[$tokens[1]] + 6
        }
        default {
            $round = $cost[$tokens[1]] + 3
        }
    }
    $score += $round
}
write-host $score
}
