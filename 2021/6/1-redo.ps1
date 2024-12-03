[int[]]$data = (gc C:\aoc\2021\6\input.txt) -split ','
$days = 80
$global:fish = ($data|measure).count
function reduce {
    param (
        $fishdays
    )
    while ($fishdays -gt 6) {
        $fishdays = $fishdays - 7
        $global:fish++
        #write-host ('fishdays', $fishdays, 'fish', $fish)
        reduce ($fishdays+2)

    }
    <#$newfish = [math]::Floor($fishdays/7)
    $global:fish = $global:fish + $newfish
    #write-host ('fishdays', $fishdays, 'newfish', $newfish, 'fish', $fish)
    for ($j = $newfish;$j -gt 1;$j--) {
        $fishdays = (($j-1)*7)+2-($data[$i]+1)
        if ($fishdays -gt 6) {
            reduce ($fishdays)
        }
    }#>
}

for ($i = 0;$i -lt $data.Count; $i++){
    #write-host ('init', $i, $data[$i])
    $fishdays = $data[$i]+$days
    #write-host ('days', $fishdays)
    reduce $fishdays
    #pause
}
$fish