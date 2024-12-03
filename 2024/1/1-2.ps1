#$data = gc C:\aoc\2024\1\test.txt
$data = gc "C:\aoc\2024\1\data.txt"
$arraya = @()
$arrayb = @()

for ($i=0;$i -lt $data.Length;$i++) {
    $split = $data[$i] -split '\s+'
    $arraya += [int]$split[0]
    $arrayb += [int]$split[1]
}

$totalsim = 0

for ($i=0;$i -lt $data.Length;$i++) {
    $vala, $valb = 0
    [int]$vala = $arraya[$i]
    $valb = $arrayb|?{$_ -eq $vala}
    $sim = $vala * $valb.length
    $totalsim += $sim
    write-host "$i, $vala, $($valb.length), $sim, $totalsim"
}

$totalsim

$arrayb |? {$_ -eq 26730}

26730 * 7