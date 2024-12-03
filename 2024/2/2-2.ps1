#$data = gc C:\aoc\2024\2\test.txt
$data = gc "C:\aoc\2024\2\data.txt"

$reports = $null
$data|%{
    $reports += ,@([int[]]$_.split(" "))
}
$safe = 0
#$reports[0]

function test {
    param([int[]]$numbers)
    $numbers = $numbers | % {if ($_){$_}}
    #write-host ($numbers -join ' ')

    $grows = $false
    $shrinks = $false
    $same = $false
    for ($i=0;$i -lt $numbers.count -1;$i++){
        $delta = $numbers[$i+1] - $numbers[$i]
        if ($delta -gt 0) {
            $grows = $true
        } elseif ($delta -lt 0) {
            $shrinks = $true
        } else {
            $same = $true
            break
        }
        if ($grows -and $shrinks) {
            break
        }

    }
    #write-host "delta $grows, $shrinks, $same"

    if (!$same -and ($grows -xor $shrinks)) {
        $numberssort = $numbers|sort
        #write-host ($numberssort -join ' ')
        $inrange = $true
        for ($i=0;$i -lt $numbers.count -1;$i++){
            $delta = $numberssort[$i+1] - $numberssort[$i]
            #write-host "$delta, $inrange"
            if ($delta -le 3 -and $delta -ge 1) {
                #nothing
            } else {
                $inrange = $false
                break
            }

        }
        if (!$inrange) {
            return $false
        } else {
            return $true
        }

    } else {
        return $false
    }
}

foreach ($report in $reports){
    $return = test $report
    #write-host "S   $($report -join ' ')"
    if (!$return) {
        for ($i=0;$i -lt $report.count;$i++){
            [System.Collections.ArrayList]$report2 = $report.Clone()
            [System.Collections.ArrayList]$report2.RemoveAt($i)
            $return = test $report2 
            if ($return) {
                #write-host "T $i $($report2 -join ' ')"
                break
            }
            #pause
        }
    }
    #write-host "E $return"
    
    #pause
    if ($return){$safe++}
    <#$dir = if ($report[-1]-$report[0] -gt 0){'INCR'}else{'DECR'}
    $cont = $true
    $damp=0

    switch ($dir){
        'INCR' {
            $range = 1..3
        }
        'DECR' {
            $range = -3..-1
        }
    }
    $done = $true
    $removal = $null
    for ($j=0;$j -lt $report.Length;$j++){
        [System.Collections.ArrayList]$report2 = $report.Clone()
        if ($removal){$report2.RemoveAt($removal)}
        for ($i=0;$i -lt $report2.count;$i++){
            $jump1 = $report2[$i+1]-$report2[$i+1]
            if ($jump1 -notin $range) {
                write-host "$i,$dir,$($report2[$i]),$($report2[$i+1]),$jump1,$damp,NGOOD"
                $damp++
                break
            } else {
                write-host "$i,$dir,$($report2[$i]),$($report2[$i+1]),$jump1,$damp,GOOD"
            }
        }
    }
    if ($cont -and $damp -le 1){$safe++}
    Write-Host "$dir, $cont, $damp, $safe"
    pause#>
            




    <#for ($i=0;$i -lt $report.Length -1;$i++){
        $jump1 = $report[$i+1]-$report[$i]
        if ($jump1 -in $range) {
            write-host "$i,$dir,$($report[$i]),$($report[$i+1]),$jump1,$damp,GOOD"
        } else {
            #write-host "$i,$dir,$($report[$i]),$($report[$i+1]),$jump1,$damp,NGOOD"
            $jump2 = $report[$i+2]-$report[$i]
            $jump3 = $report[$i+1]-$report[$i-1]
            if ($i -lt $report.Length -1 -and ($jump2 -in $range) -and $damp -eq 0) {
                $damp++
                write-host "$i,$dir,,$($report[$i]),$($report[$i+2]),$jump1,2,$jump2,$damp,JumpFwdDAMP"
                $i++
            }
            elseif (
                $i -ge 1 -and $jump3 -in $range -and $damp -eq 0
            ) {
                $damp++
                write-host "$i,$dir,$($report[$i-1]),$($report[$i+1]),$jump1,3,$jump3,$damp,JumpBackDAMP"
                #$i++
            } elseif ($damp -eq 0 -and $i -eq $report.Length -2) {
                $damp++
                write-host "$i,$dir,$($report[$i]),$($report[$i+1]),$jump1,3,$jump3,$damp,LastDAMP"
                $i++   
            } else {
                $cont = $false
                write-host "$i,$dir,$($report[$i-1]),$($report[$i]),$($report[$i+1]),$jump1,$jump2,$jump3,$damp,FAIL"
            }
        }
        if (!$cont -or $damp -gt 1){break}
    }#>
    #if ($cont -and $damp -lt 2){$safe++}
    #Write-Host "$dir, $cont, $damp, $safe"
    #pause
}
$safe 
