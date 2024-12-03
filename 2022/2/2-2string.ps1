measure-command {
[int]$score = 0
$cost = @{
    'A X' = 3
    'A Y' = 4
    'A Z' = 8
    'B X' = 1
    'B Y' = 5
    'B Z' = 9
    'C X' = 2
    'C Y' = 6
    'C Z' = 7
}
foreach ($line in gc "C:\Users\mihkel.soomere\OneDrive\AoC\2022\2\input.txt") {
    $score += $cost[$line]
}
write-host $score
}