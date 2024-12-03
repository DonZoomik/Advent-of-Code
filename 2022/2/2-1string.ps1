[string[]]$inputdata = gc "C:\Users\mihkel.soomere\OneDrive\AoC\2022\2\input.txt"|%($_){$_}
[int]$score = 0
$cost = @{
    'A X' = 4 # Rock-Rock, Draw 3 + Rock 1
    'A Y' = 8 # Paper Win Rock, Win 6 + Paper 2
    'A Z' = 9 # Scissor
    'B X' = 1
    'B Y' = 5
    'B Z' = 9
    'C X' = 1
    'C Y' = 2
    'C Z' = 6
}
$data = foreach ($line in $inputdata) {
    $cost[$line.trim()]
}
($data|measure -sum).sum