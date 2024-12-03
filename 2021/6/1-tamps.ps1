[int[]]$data = (gc C:\aoc\2021\6\input.txt) -split ','
$freq= New-Object int64[] 9
foreach ($int in $data){
    $freq[$int]++
}
$days=256
for ($j=0;$j -lt $days;$j++) {
    $freq[7] = ($freq[7] + $freq[0])
    $freq = $freq[1..($freq.Count-1)] + $freq[0]
}
($freq|measure -sum).sum

#3,5,3,2,2,1,5,1,4

#remove-variable freq