[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\4\input.txt"
[int]$totallycontained = 0
foreach ($line in $inputdata) {
    $tokens = $line -split ','
    [int[]]$e1 = $tokens[0] -split '-'
    [int[]]$e2 = $tokens[1] -split '-'
    $e1min = $e1[0]
    $e1max = $e1[1]
    $e2min = $e2[0]
    $e2max = $e2[1]
    Write-Host ($e1min, $e1max, $e2min, $e2max)
    [int]$lmc=0
    switch ($null) {
        {$e1min -ge $e2min -and $e1max -le $e2max} {
            $e1min -ge $e2min
            $e1max -le $e2max
            'elf1 included'
            write-host ($line)
            $lmc++
        }
        {$e2min -ge $e1min -and $e2max -le $e1max} {
            $e2min -ge $e1min
            $e2max -le $e1max
            'elf2 included'
            write-host ($line)
            $lmc++
        }
    }
    $lmc
    if ($lmc){$totallycontained++}
}
$totallycontained
