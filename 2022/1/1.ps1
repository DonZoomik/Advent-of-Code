$input = gc "C:\Users\Mihkel\OneDrive\AoC\2022\1\input.txt"
[int]$calsingle = 0
$calorylist = for ($i=0;$i -lt $input.Count;$i++){
    if ($input[$i]){
        $calsingle += [int]$input[$i]
    } else {
        $calsingle
        [int]$calsingle = 0
    }
}
write-host ($calorylist|sort -desc)[0]
write-host (($calorylist|sort -desc)[0..2]|measure -sum).sum