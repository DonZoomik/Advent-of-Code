[string[]]$data = gc C:\aoc\2021\4\input.txt|%{if($_){$_}}

[int[]]$winnumbers = $data[0] -split ','

$fields = @()
for ($i=1;($i+4) -lt $data.Length;$i = $i+5) {
  #write-host ($i, $data[$i])
  $field= @()
  for ($j=$i;$j -lt ($i+5);$j++) {
    #write-host ($i, $j, $data[$j])
    foreach ($c in ($data[$j].trim() -split '\s+')) {
        #$c
        $field += @{
            value=[int]$c
            match=0
        }
    }
  }
  #$field.Count
  $fields+=@(,$field)
  #$fields.length
  #pause
}

#numbers
for($i=0;$i -lt $winnumbers.Length;$i++){
    #fields
    write-host ('winnumproc', $i, $winnumbers[$i])
    for($j=0; $j -lt $fields.Length;$j++) {
        write-host ('fieldproc', $j)
        for ($n=0;$n -lt $fields[$j].length;$n++){
        #foreach ($num in $fields[$j]) {
            #write-host ('valueproc', $i, $winnumbers[$i], $j, $n, $fields[$j][$n].value, $fields[$j][$n].match)
            if ([int]$winnumbers[$i] -eq [int]$fields[$j][$n].Value) {
                $fields[$j][$n].match = 1
                #write-host ('fieldmatch', 'winnum',$i, $winnumbers[$i], 'field', $j, $n, $fields[$j][$n].value, $fields[$j][$n].match)
                #pause
            }
        }
        #pause
        #test rows



        #5 rows
        
        for ($k=0;$k -lt 5;$k++) {
            $rowmatch=0
            #rowposition
            for ($l=$k*5;$l -lt (($k*5)+5);$l++) {
                if ($fields[$j][$l].match -eq 1) { 
                    $rowmatch++
                    #write-host ('rowmatch','winnum', $i, 'value', $winnumbers[$i], 'field', $j,'row', $k,'pos', $l,'value', $fields[$j][$l].value, $fields[$j][$l].match, $rowmatch)
                }
            }
            if ($rowmatch -eq 5) {
                write-host ("5inrow", 'winnum', $i, 'value', $winnumbers[$i], 'field', $j,'row', $k)
                $fields[$j][($k*5)..(($k*5)+4)].match -join ' '|write-host
                $fields[$j][($k*5)..(($k*5)+4)].value -join ' '|write-host
                #pause
                $unmarked = $fields[$j]| ? match -eq 0
                $unmarked.value -join ' '|write-host
                $unmarkedsum = ($unmarked.value|measure -sum).sum
                write-host $unmarkedsum
                $unmarkedsum * $winnumbers[$i]
                pause
            }
        }
        #>

        #test colums
        #5 columns
        for ($k=0;$k -lt 5;$k++) {
            $columnmatch=0
            for ($l=$k;$l -lt $fields[$j].length;$l=$l+5) {
                if ($fields[$j][$l].match -eq 1) {
                    $columnmatch++
                    #write-host ('columnmatch','winnum', $i, 'value', $winnumbers[$i], 'field', $j,'column', $k,'pos', $l,'value', $fields[$j][$l].value, $fields[$j][$l].match, $columnmatch)
                }
            }
            if ($columnmatch -eq 5) {
                write-host ("5incolumn", 'winnum', $i, 'value', $winnumbers[$i], 'field', $j,'column', $k)
                $fields[$j][0..4].match -join ' '|write-host
                $fields[$j][5..9].match -join ' '|write-host
                $fields[$j][10..14].match -join ' '|write-host
                $fields[$j][15..19].match -join ' '|write-host
                $fields[$j][20..24].match -join ' '|write-host
                #pause
                $unmarked = $fields[$j]| ? match -eq 0
                $unmarked.value -join ' '|write-host
                $unmarkedsum = ($unmarked.value|measure -sum).sum
                write-host $unmarkedsum
                $unmarkedsum * $winnumbers[$i]
                pause
            }
        }

    }
    <#if ((5,10,11) -contains $i) {
        #visualize
        $fields[0][0..4].match -join ' '|write-host
        $fields[0][5..9].match -join ' '|write-host
        $fields[0][10..14].match -join ' '|write-host
        $fields[0][15..19].match -join ' '|write-host
        $fields[0][20..24].match -join ' '|write-host
        ''
        $fields[1][0..4].match -join ' '|write-host
        $fields[1][5..9].match -join ' '|write-host
        $fields[1][10..14].match -join ' '|write-host
        $fields[1][15..19].match -join ' '|write-host
        $fields[1][20..24].match -join ' '|write-host
        ''
        $fields[2][0..4].match -join ' '|write-host
        $fields[2][5..9].match -join ' '|write-host
        $fields[2][10..14].match -join ' '|write-host
        $fields[2][15..19].match -join ' '|write-host
        $fields[2][20..24].match -join ' '|write-host
        pause
    #}#>
    #pause
}

#>