[string[]]$inputdata = gc "C:\Users\Mihkel\OneDrive\AoC\2022\3\input.txt"
[int]$sum = 0
[char[]]$cost=("a".."z")+("A".."Z")
[char[]]$commonchar = @()
foreach ($line in $inputdata) {
    [char[]]$linechars = $line.ToCharArray()
    [char[]]$pocket1 = $linechars[0..(($linechars.Count/2) -1)]
    [char[]]$pocket2 = $linechars[(($linechars.Count/2) )..($linechars.Count -1)]
    $linematch = foreach ($c in $pocket1) {
        if ($c -cin $pocket2) {
            $c
        }
    }
    $commonchar += ($linematch| select -Unique)
}
foreach ($cc in $commonchar){
    $sum += ([array]::IndexOf($cost,$cc)) + 1
}
$sum