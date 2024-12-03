$data = (gc C:\aoc\2021\9\input.txt)
$rowlength=$data[0].Length
[int[]]$dataline=($data).ToCharArray()
$riskpoints=@()
for ($i=1;$i -le $dataline.Count;$i++) {
    $mod = $dataline.Count % $i
    $mod
}