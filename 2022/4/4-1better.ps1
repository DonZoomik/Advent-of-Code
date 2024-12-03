[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\4\input.txt"
[int]$totallycontained = 0
foreach ($line in $inputdata) {
    [int[]]$tokens = $line -split '-|,'
    if (($tokens[0] -ge $tokens[2] -and $tokens[1] -le $tokens[3]) -or ($tokens[2] -ge $tokens[0] -and $tokens[3] -le $tokens[1])) {
        $totallycontained++
    }
}
$totallycontained