remove-variable data
$data = gc C:\aoc\2021\6\input.txt
$days = 256
[int[]]$datasplit = $data -split ','
$oldfish=$datasplit.Count
$newfish=0
$day = New-Object 'int[]' (1000000)
[array]::Copy($datasplit,$day,$oldfish)

for ($i=1;$i -le $days;$i++) {
    $newfish=0
    #write-host ('day sta', $i, 'fish', ($day[0..($oldfish-1)] -join ','))
    for ($k=0;$k -lt $oldfish;$k++) {
        if ($day[$k] -gt 0) {
            $day[$k]--
        } else {
            $day[$k] = 6
            $newfish++
        }
    }
    for ($j=$oldfish;$j -lt ($oldfish+$newfish);$j++){
        $day[$j] = 8
    }
    #write-host ('day end', $i, 'fish', ($day[0..($oldfish+$newfish-1)] -join ','))
    $oldfish = $oldfish + $newfish
    if ($i -eq $days){
        ($day[0..($oldfish-1)]|measure -sum).count
        exit
    }
    #pause
}

