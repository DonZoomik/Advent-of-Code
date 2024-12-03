#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\11\input1.txt"
[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\11\input2.txt"

$monkeys = @()
$magic = 9699690
#$magic=96577

for ($i=0;$i -lt $inputdata.Count;$i=$i+7) {
    [int]$monkeynumber = ($inputdata[$i].trim(':') -split ' ')[1]
    $queue = New-Object System.Collections.Queue
    (($inputdata[$i+1].trim() -split ':')[1] -split ',')|%{$_.trim()}|%{$queue.Enqueue([bigint]$_)}
    $operationtokens = $inputdata[$i+2].trim() -split ' '
    $operation = $operationtokens[4]
    $selfoperator = $false
    $operator = 0
    if ($operationtokens[5] -match "^\d+$") {
        [int]$operator = $operationtokens[5]
    } else {$selfoperator = $true}
    [int]$test = ($inputdata[$i+3].trim() -split ' ')[3]
    [int]$truetarget = ($inputdata[$i+4].trim() -split ' ')[5]
    [int]$falsetarget = ($inputdata[$i+5].trim() -split ' ')[5]

    $monkeys += [PSCustomObject]@{
        Number = $monkeynumber
        Queue = $queue
        Operation = $operation
        Operator = $operator
        SelfOperator = $selfoperator
        Test = $test
        TrueTarget = $truetarget
        FalseTarget = $falsetarget
        Inspected = 0
    }
}


for ($i=0;$i -lt 10000;$i++){
    foreach ($monkey in $monkeys) {
        $jl=$monkey.Queue.Count
        for ($j=0;$j -lt $jl;$j++){
            $itemtoprocess = $monkey.Queue.Dequeue()
            $expression = '$itemtoprocess', $monkey.Operation -join ' '
            if ($monkey.SelfOperator) {
                $expression = $expression, '$itemtoprocess' -join ' ' 
            } else {
                $expression = $expression, '$monkey.operator' -join ' ' 
            }
            #$newworry = Invoke-Expression $expression
            [bigint]$bored = Invoke-Expression $expression
            #$bored = [math]::floor($newworry / 3)

            if ($bored -ge $magic) {
                $bored = $bored % $magic
            }
        
            $modulus = $bored % $monkey.test

            if (!$modulus) {
                #Write-host ('monkey', $monkey.Number, 'item', $j, $itemtoprocess, 'exp', $expression, 'new', $newworry,'bored',$bored, 'test', $test,'mod', $modulus, 'hit', $monkey.truetarget)
                $monkeys[$monkey.truetarget].Queue.Enqueue($bored)
            } else {
                #Write-host ('monkey', $monkey.Number, 'item', $j, $itemtoprocess, 'exp', $expression, 'new', $newworry, 'bored',$bored,'test', $test,'mod', $modulus, 'miss', $monkey.falsetarget)
                $monkeys[$monkey.falsetarget].Queue.Enqueue($bored)
            }
            $monkey.Inspected++
        }
    }
    
    
    if ($i -in (0,19,999,1999,2999,3999,4999,5999,6999,7999,8999,9999)) {
        write-host $i
        $monkeys|ft -AutoSize
        #pause
    }#>
}
$mostactive = $monkeys |sort Inspected -Descending|select -First 2
$mostactive[0].Inspected * $mostactive[1].Inspected


