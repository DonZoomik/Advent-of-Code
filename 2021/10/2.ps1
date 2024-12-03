$data = (gc C:\aoc\2021\10\input.txt)
#[string[]]$illegals=@()
[int64[]]$totalscores=@()
for ($y=0;$y -lt $data.Length;$y++) {
    [string[]][char[]]$row = $data[$y]
    [string[]]$lastinc=@()
    $rowconsistent=$true
    [int64]$rowscore = 0
    write-host ('row', $y)
    :poscounter for ($x=0;$x -lt $row.Count;$x++){
        #write-host ('row', $y, 'pos', $x, 'char', $row[$x])
        switch ($row[$x]){
            '(' {$lastinc += '('}
            '[' {$lastinc += '['}
            '{' {$lastinc += '{'}
            '<' {$lastinc += '<'}
            ')' {
                if ($lastinc[-1] -eq '('){
                    write-host ($lastinc -join '')
                    if (($lastinc.Count-2) -eq -1) {[string[]]$lastinc=@()} else {$lastinc=$lastinc[0..($lastinc.Count-2)]}
                } else {
                    #$illegals+=$_
                    $rowconsistent=$false
                    write-host ('row', $y,'pos', $x, 'arr', ($lastinc -join ''), 'exp', $lastinc[-1], 'act', $_, 'ill', ($illegals -join ''))
                    #pause
                    break poscounter
                }
            }
            ']' {
                if ($lastinc[-1] -eq '['){
                    write-host ($lastinc -join '')
                    if (($lastinc.Count-2) -eq -1) {[string[]]$lastinc=@()} else {$lastinc=$lastinc[0..($lastinc.Count-2)]}
                } else {
                    #$illegals+=$_
                    $rowconsistent=$false
                    write-host ('row', $y,'pos', $x, 'arr', ($lastinc -join ''), 'exp', $lastinc[-1], 'act', $_, 'ill', ($illegals -join ''))
                    #pause
                    break poscounter
                }
            }
            '}' {
                if ($lastinc[-1] -eq '{'){
                    write-host ($lastinc -join '')
                    if (($lastinc.Count-2) -eq -1) {[string[]]$lastinc=@()} else {$lastinc=$lastinc[0..($lastinc.Count-2)]}
                } else {
                    #$illegals+=$_
                    $rowconsistent=$false
                    write-host ('row', $y,'pos', $x, 'arr', ($lastinc -join ''), 'exp', $lastinc[-1], 'act', $_, 'ill', ($illegals -join ''))
                    #pause
                    break poscounter
                }}
            '>' {
                if ($lastinc[-1] -eq '<'){
                    write-host ($lastinc -join '')
                    if (($lastinc.Count-2) -eq -1) {[string[]]$lastinc=@()} else {$lastinc=$lastinc[0..($lastinc.Count-2)]}
                } else {
                    #$illegals+=$_
                    $rowconsistent=$false
                    write-host ('row', $y,'pos', $x, 'arr', ($lastinc -join ''), 'exp', $lastinc[-1], 'act', $_, 'ill', ($illegals -join ''))
                    #pause
                    break poscounter
                }
            }
        }
    }
    if ($rowconsistent) {
        for ($i = ($lastinc.Count-1);$i -ge 0;$i--) {
            switch ($lastinc[$i]){
                '(' {$rowscore = $rowscore*5 + 1}
                '[' {$rowscore = $rowscore*5 + 2}
                '{' {$rowscore = $rowscore*5 + 3}
                '<' {$rowscore = $rowscore*5 + 4}
            }
            write-host ('row', $y, 'ill', ($lastinc -join ''), 'pos', $i, 'val', $lastinc[$i], 'rowscore', $rowscore )
        }
        write-host ($rowscore)
        $totalscores+=$rowscore
    }
}

$totalscores=$totalscores|sort
$totalscores[[math]::Floor($totalscores.Count/2)]