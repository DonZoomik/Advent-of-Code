#$data = gc C:\aoc\2024\1\test.txt
$data = gc "C:\aoc\2024\1\data.txt"
$arraya = @()
$arrayb = @()

for ($i=0;$i -lt $data.Length;$i++) {
    $split = $data[$i] -split '\s+'
    $arraya += [PSCustomObject]@{pos=$i;val=$split[0]}
    $arrayb += [PSCustomObject]@{pos=$i;val=$split[1]}
}

$arrayasort = $arraya | sort -Property val
$arraybsort = $arrayb | sort -Property val

$totaldistance = 0

for ($i=0;$i -lt $data.Length;$i++) {
    #$arrayasort[$i]
    #$arraybsort[$i]
    $dist = $arrayasort[$i].val - $arraybsort[$i].val
    $totaldistance += [math]::Abs($dist)
}
$totaldistance