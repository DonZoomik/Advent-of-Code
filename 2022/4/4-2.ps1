[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\4\input.txt"
[int]$totallycontained = 0
foreach ($line in $inputdata) {
    [int[]]$tokens = $line -split '-|,'
    $overlap = Compare-Object -ReferenceObject ($tokens[0]..$tokens[1]) -DifferenceObject ($tokens[2]..$tokens[3]) -IncludeEqual -ExcludeDifferent
    if ($overlap) {
        $totallycontained++
    }
}
$totallycontained