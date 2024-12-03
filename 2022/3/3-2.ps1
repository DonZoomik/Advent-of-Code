[string[]]$inputdata = gc "C:\Users\Mihkel\OneDrive\AoC\2022\3\input.txt"
[int]$sum = 0
[char[]]$cost=("a".."z")+("A".."Z")
[char[]]$commonchar = @()
for ($i=0;$i -lt $inputdata.Count;$i=$i+3) {
    [char[]]$backpack1 = $inputdata[$i].ToCharArray()
    [char[]]$backpack2 = $inputdata[$i+1].ToCharArray()
    [char[]]$backpack3 = $inputdata[$i+2].ToCharArray()
    $linematch = foreach ($c in $backpack1) {
        if ($c -cin $backpack2 -and $c -cin $backpack3) {
            $c
        }
    }
    $commonchar += ($linematch| select -Unique)
}
foreach ($cc in $commonchar){
    $sum += ([array]::IndexOf($cost,$cc)) + 1
}
$sum