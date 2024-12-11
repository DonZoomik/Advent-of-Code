#$data = gc "C:\aoc\Advent-of-Code\2024\9\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\9\data.txt"

$digits = $data.ToCharArray()|%{[System.Int32]::Parse($_)}
$bitmaplength = ($digits|measure -sum).sum
$bitmap = New-Object 'object[]' $bitmaplength

$pos=0
$numdigit=0
for ($i=0;$i -lt $digits.count;$i++) {
    switch ($i%2) {
        '0' {
            #file
            for ($j=0;$j -lt $digits[$i];$j++) {
                $bitmap[$pos] = $numdigit
                $pos++
            }
            $numdigit++
        }
        '1' {
            for ($j=0;$j -lt $digits[$i];$j++) {
                $bitmap[$pos] = '.'
                $pos++
            }
        }
    }
}
$bitmap -join ''|write-host

$lastfree = 0
for ($i = ($bitmap.count-1);$i -ge 0;$i--) {
    if ($bitmap[$i] -ne '.') {
        #write-host "I $i $($bitmap[$i])"
        for ($j=$lastfree;$j -lt $i;$j++) {
            #write-host "J $j $lastfree $($bitmap[$j])"
            if ($bitmap[$j] -eq '.' ) {
                $bitmap[$j] = $bitmap[$i]
                $bitmap[$i] = '.'
                $lastfree++
                break
            } else {
                $lastfree++
            }
        }
    }
}
$bitmap -join ''|write-host
$numbers = for ($i = 0;$i -lt $bitmap.count;$i++) {
    if ($bitmap[$i] -ne '.') {
        $i * $bitmap[$i]
    } else {break}
}
$numbers|measure -sum