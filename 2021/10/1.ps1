$data = (gc C:\aoc\2021\10\input.txt)
$illegals=@()
[pscustomobject]$counter=@{
    '('=0
    '['=0
    '{'=0
    '<'=0

}
for ($y=0;$y -lt $data.Length;$y++) {
    [string[]][char[]]$row = $data[$y]
    for ($x=0;$x -lt $row.Count;$x++){
        switch ($row[$x]){
            '(' {$counter.'('++}
            '[' {$counter.'['++}
            '{' {$counter.'{'++}
            '<' {$counter.'<'++}
            ')' {$counter.'('--}
            ']' {$counter.'['--}
            '}' {$counter.'{'--}
            '>' {$counter.'<'--}
        }
        write-host ('pos',$x,'(',$counter.'(',
    }
    $counter
    pause
}
