#$data = gc C:\aoc\2024\2\test.txt
$data = gc "C:\aoc\2024\2\data.txt"

$reports = $null
$data|%{
    $reports += ,[int[]]$_.split(" ")
}
$safe = 0

foreach ($report in $reports){
    $dir = if ($report[1]-$report[0] -gt 0){$true}else{$false}
    $cont = $true
    for ($i=0;$i -lt $report.Length -1 ;$i++){
        switch ($dir){
            $true {
                if ($report[$i+1]-$report[$i] -in (1..3)) {    
                } else {$cont = $false}
                #write-host "$i,$dir,$($report[$i]),$($report[$i+1]),$cont"
            }
            $false {
                if ($report[$i+1]-$report[$i] -in (-3..-1)) {
                } else {$cont = $false}
                #write-host "$i,$dir,$($report[$i]),$($report[$i+1]),$cont"
            }
        }
        if (!$cont){break}
    }
    if ($cont){$safe++}
    #Write-Host "$($report -join ' '), $dir, $cont, $safe"
    #pause
}
$safe