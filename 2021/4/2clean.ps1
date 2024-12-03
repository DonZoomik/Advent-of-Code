[string[]]$data = gc C:\aoc\2021\4\input.txt|%{if($_){$_}}
[int[]]$winnumbers = $data[0] -split ','
$fields = @()
for ($i=1;($i+4) -lt $data.Length;$i = $i+5) {
  $field= @()
  for ($j=$i;$j -lt ($i+5);$j++) {  
    foreach ($c in ($data[$j].trim() -split '\s+')) {
        $field += @{
            value=[int]$c
            match=0
        }
    }
  }
  $fields+=@(,$field)
}
$boardswon = New-Object int[] $fields.Count
for($i=0;$i -lt $winnumbers.Length;$i++){
    for($j=0; $j -lt $fields.Length;$j++) {
        for ($n=0;$n -lt $fields[$j].length;$n++){
            if ([int]$winnumbers[$i] -eq [int]$fields[$j][$n].Value) {
                $fields[$j][$n].match = 1
            }
        }
        for ($k=0;$k -lt 5;$k++) {
            $rowmatch=0
            for ($l=$k*5;$l -lt (($k*5)+5);$l++) {
                if ($fields[$j][$l].match -eq 1) { 
                    $rowmatch++
                }
            }
            if ($rowmatch -eq 5) {
                $boardswon[$j] = 1
            }
        }
        for ($k=0;$k -lt 5;$k++) {
            $columnmatch=0
            for ($l=$k;$l -lt $fields[$j].length;$l=$l+5) {
                if ($fields[$j][$l].match -eq 1) {
                    $columnmatch++
                }
            }
            if ($columnmatch -eq 5) {
                $boardswon[$j] = 1
            }
        }
        $allboardswon = 1
        foreach ($board in $boardswon){
            if ($board -eq 0) {
                $allboardswon = 0
            }
        }
        if ($allboardswon -eq 1) {
            $unmarked = $fields[$j]| ? match -eq 0
            $unmarkedsum = ($unmarked.value|measure -sum).sum
            $unmarkedsum * $winnumbers[$i]
            exit
        }
    }
}
