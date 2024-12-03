$data = (gc C:\aoc\2021\10\input.txt)
[string[]]$illegals=@()
for ($y=0;$y -lt $data.Length;$y++) {
    [string[]][char[]]$row = $data[$y]
    [string[]]$lastinc=@()
    #skip incomplete
    #if ($row[-1] -notmatch '\(|\[|\{|\<') { 
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
                        $lastinc=$lastinc[0..($lastinc.Count-2)]
                    } else {
                        $illegals+=$_
                        write-host ('row', $y,'pos', $x, 'arr', ($lastinc -join ''), 'exp', $lastinc[-1], 'act', $_, 'ill', ($illegals -join ''))
                        #pause
                        break poscounter
                    }
                }
                ']' {
                    if ($lastinc[-1] -eq '['){
                        $lastinc=$lastinc[0..($lastinc.Count-2)]
                    } else {
                        write-host ('row', $y,'pos', $x, 'arr', ($lastinc -join ''), 'exp', $lastinc[-1], 'act', $_, 'ill', ($illegals -join ''))
                        $illegals+=$_
                        #pause
                        break poscounter
                    }
                }
                '}' {
                    if ($lastinc[-1] -eq '{'){
                        $lastinc=$lastinc[0..($lastinc.Count-2)]
                    } else {
                        write-host ('row', $y,'pos', $x, 'arr', ($lastinc -join ''), 'exp', $lastinc[-1], 'act', $_, 'ill', ($illegals -join ''))
                        $illegals+=$_
                        #pause
                        break poscounter
                    }}
                '>' {
                    if ($lastinc[-1] -eq '<'){
                        $lastinc=$lastinc[0..($lastinc.Count-2)]
                    } else {
                        write-host ('row', $y,'pos', $x, 'arr', ($lastinc -join ''), 'exp', $lastinc[-1], 'act', $_, 'ill', ($illegals -join ''))
                        $illegals+=$_
                        #pause
                        break poscounter
                    }
                }
            }
        }
    #}
}
$illegalssum = 0
$illegals -join ''
$illegals|group|%{
    $item = $_
    switch ($_.name){
        ')' {$illegalssum = $illegalssum + $item.count*3}
        ']' {$illegalssum = $illegalssum + $item.count*57}
        '}' {$illegalssum = $illegalssum + $item.count*1197}
        '>' {$illegalssum = $illegalssum + $item.count*25137}
    }
}
$illegalssum