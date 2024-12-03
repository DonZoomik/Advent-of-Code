[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\5\input.txt"
$stacks = @{
    1=[System.Collections.ArrayList]@()
    2=[System.Collections.ArrayList]@()
    3=[System.Collections.ArrayList]@()
    4=[System.Collections.ArrayList]@()
    5=[System.Collections.ArrayList]@()
    6=[System.Collections.ArrayList]@()
    7=[System.Collections.ArrayList]@()
    8=[System.Collections.ArrayList]@()
    9=[System.Collections.ArrayList]@()
}
$endofstacks = 0
for ($i=0;$i -lt $inputdata.Count;$i++){
    if ($inputdata[$i]) {
        $line = $inputdata[$i].ToCharArray()
        $column = 1
        for ($j=1;$j -lt $line.Count;$j=$j+4){
            if ($line[$j] -in "A".."Z") {
                $crate = $line[$j]
                $stacks[$column].Add($crate)
            }
            $column++
        }
    } else {
        $endofstacks = $i +1 
        break
    }
}
$stacks[1].Reverse()
$stacks[2].Reverse()
$stacks[3].Reverse()
$stacks[4].Reverse()
$stacks[5].Reverse()
$stacks[6].Reverse()
$stacks[7].Reverse()
$stacks[8].Reverse()
$stacks[9].Reverse()
for ($i=$endofstacks;$i -lt $inputdata.Count;$i++){
    $tokens = $inputdata[$i] -split ' '
    [int]$count = $tokens[1]
    [int]$source = $tokens[3]
    [int]$target = $tokens[5]
    for ($j=0;$j -lt $count;$j++){
        $cut = $stacks[$source][-1]
        $stacks[$source].RemoveAt($stacks[$source].Count-1)
        $stacks[$target].Add($cut)
    }
}
$stacks[1][-1],$stacks[2][-1],$stacks[3][-1],$stacks[4][-1],$stacks[5][-1],$stacks[6][-1],$stacks[7][-1],$stacks[8][-1],$stacks[9][-1] -join ''